import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  // getter
  List<dynamic> get nfts => _nfts;

  final WalletController _walletController = Get.put(WalletController());

  Future<void> init() async {
    final infuraUrl = dotenv.get('INFURA_URL');
    final infuraWsUrl = dotenv.get('INFURA_WSURL');
    print(infuraUrl);
    print(infuraWsUrl);
    _web3client = Web3Client(infuraUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(infuraWsUrl).cast<String>();
    });
    await getABI();
    await getCredentials();
    await getDeployedContract();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
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
    _abiCode = ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'MyNFT');
    _contractAddress =
        EthereumAddress.fromHex(jsonABI['networks']['11155111']['address']);
    print(jsonABI['networks']['11155111']['address']);
  }

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode!, _contractAddress!);
    _getMyNfts = _deployedContract!.function('getNfts');
    _createNft = _deployedContract!.function('createNft');
  }

  Future<void> getMyNfts(String address) async {
    await init();
    print("address: ${address}");
    List nftList = await _web3client!.call(
        sender: EthereumAddress.fromHex(address),
        contract: _deployedContract!,
        function: _getMyNfts!,
        params: []);
    nftList[0].removeAt(0);
    _myNfts = nftList[0];
    _myNfts.removeWhere(
        (item) => item[1] == EthereumAddress.fromHex(genesisAddress));
    print("-----------");
    print(nftList);

    print(_myNfts);
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
        chainId: 11155111);
    // local chainId: 5777 / deploy chainId: 11155111
    getMyNfts(publicAddress.toString());
  }
}
