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
  ContractFunction? _sendNft;
  ContractFunction? _getNftsCount;

  List<dynamic> _nfts = [];
  List<Map> _nftStructList = [];
  // getter
  List<dynamic> get nfts => _nfts;
  List<Map> get nftStructList => _nftStructList;

  final WalletController _walletController = Get.put(WalletController());
  final adminPrivateKey = dotenv.get("FESTIVAL_ADMIN_WALLET_PRIVATE_KEY");

  Future<void> init() async {
    final infuraUrl = dotenv.get('INFURA_URL');
    final infuraWsUrl = dotenv.get('INFURA_WSURL');
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
    _creds = EthPrivateKey.fromHex(adminPrivateKey);
  }

  Future<void> getCredentials() async {
    _creds = EthPrivateKey.fromHex(adminPrivateKey);
  }

  // abi 파일 얻기
  Future<void> getABI() async {
    final String abiFile =
        await rootBundle.loadString('assets/json/MyNFT.json');
    final jsonABI = jsonDecode(abiFile);
    _abiCode = ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'MyNFT');
    _contractAddress =
        EthereumAddress.fromHex(jsonABI['networks']['11155111']['address']);
  }

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode!, _contractAddress!);
    _getMyNfts = _deployedContract!.function('getNfts');
    _createNft = _deployedContract!.function('createNft');
    _sendNft = _deployedContract!.function('sendNft');
    _getNftsCount = _deployedContract!.function('getNftsCount');
  }

  Future<void> getMyNfts(String address) async {
    await init();
    print("address: ${address}");
    List nftList = await _web3client!.call(
        sender: EthereumAddress.fromHex(address),
        contract: _deployedContract!,
        function: _getMyNfts!,
        params: []);

    _nfts = nftList[0];
    _nfts.removeWhere(
        (item) => item[1] == EthereumAddress.fromHex(genesisAddress));
    _nftStructList = [];
    for (int i = 0; i < _nfts.length; i++) {
      Map<String, String> map = {};
      map['tokenId'] = _nfts[i][0].toString();
      map['owner'] = _nfts[i][1].toString();
      map['title'] = _nfts[i][2].toString();
      map['description'] = _nfts[i][3].toString();
      map['image'] = _nfts[i][4].toString();
      map['tokenUri'] = _nfts[i][5].toString();
      _nftStructList.add(map);
    }
    print(nftStructList);
    update();
  }

  // 축제 관리자에게 nft 소유권을 먼저 보유
  Future<void> createNft(
      String tokenUri, String title, String description, String image) async {
    await init();
    final publicAddress = await _walletController.getPublicKey(adminPrivateKey);
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            from: EthereumAddress.fromHex(publicAddress.toString()),
            contract: _deployedContract!,
            function: _createNft!,
            parameters: [tokenUri, title, description, image]),
        chainId: 11155111);
    // local chainId: 5777 / deploy chainId: 11155111
  }

  // 관리자가 가지고 있는 것을 보내주는 것
  Future<void> sendNft(BigInt tokenId) async {
    await init();

    final adminAddress = await _walletController.getPublicKey(adminPrivateKey);
    final publicAddress =
        await _walletController.getPublicKey(_walletController.privateKey);
    print("address -----");
    print(adminAddress.toString());
    print(publicAddress.toString());
    await _web3client!.sendTransaction(
        _creds,
        Transaction.callContract(
            from: EthereumAddress.fromHex(adminAddress.toString()),
            contract: _deployedContract!,
            function: _sendNft!,
            parameters: [adminAddress, publicAddress, tokenId]),
        chainId: 11155111);
    getMyNfts(publicAddress.toString());
  }

  Future<BigInt> getNfsCount() async {
    await init();
    final publicAddress =
        await _walletController.getPublicKey(_walletController.privateKey);
    final count = await _web3client!.call(
        contract: _deployedContract!, function: _getNftsCount!, params: []);
    print(count);
    // count - 1을 해줘야한다.
    print("count: ${count[0]}");

    return count[0] - BigInt.from(1);
  }
}
