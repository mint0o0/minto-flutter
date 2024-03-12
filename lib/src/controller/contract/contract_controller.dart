import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import '../../utils/config.dart';
import '../wallet/wallet_controller.dart';

class NftController extends GetxController {
  Web3Client? _web3client;
  ContractAbi? _abiCode;
  EthereumAddress? _contractAddress;
  DeployedContract? _deployedContract;
  // insertPrivate Key
  late EthPrivateKey _creds;
  ContractFunction? _getMyNfts;
  ContractFunction? _createNft;
  double _balance = 0.00;
  List<dynamic> _nfts = [];
  List<dynamic> _myNfts = [];

  List<dynamic> get nfts => _nfts;

  final WalletController _walletController = Get.put(WalletController());

  Future<void> init() async {
    _web3client = Web3Client(url, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    await getABI();
    await getDeployedContract();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    print("private Key: ${_walletController.privateKey}");
    _creds = EthPrivateKey.fromHex(_walletController.privateKey);
  }

  Future<void> getCredentials() async {
    _creds = EthPrivateKey.fromHex(_walletController.privateKey);
  }

  // abi 파일 얻기
  Future<void> getABI() async {
    final String abiFile =
        await rootBundle.loadString('assets/json/MyNFT.json');
    final jsonABI = jsonDecode(abiFile);
    _abiCode = ContractAbi.fromJson(jsonABI['abi'], jsonABI['MyNFT']);
    _contractAddress = EthereumAddress.fromHex(
        json.encode(jsonABI['networks']['5777']['address']));
  }

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode!, _contractAddress!);
    _getMyNfts = _deployedContract!.function('getNfts');
    _createNft = _deployedContract!.function('createNft');
  }

  Future<void> getMyNfts(String address) async {
    await init();
    List nftList = await _web3client!.call(
        sender: EthereumAddress.fromHex(address),
        contract: _deployedContract!,
        function: _getMyNfts!,
        params: []);
    nftList[0].removeAt(0);
    _myNfts = nftList[0];
    _myNfts.removeWhere(
        (item) => item[1] == EthereumAddress.fromHex(genesisAddress));

    update();
  }

  Future<void> createNft(
      String tokenUri, String title, String description, String image) async {
    await init();
    final publicAddress =
        await _walletController.getPublicKey(_walletController.privateKey);
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            from: EthereumAddress.fromHex(publicAddress.toString()),
            contract: _deployedContract!,
            function: _createNft!,
            parameters: [tokenUri, title, description, image]),
        chainId: 5777);
    // local chainId: 5777 / deploy chainId: 11155111
    getMyNfts(publicAddress.toString());
  }
}
