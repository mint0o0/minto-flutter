import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minto/src/utils/func.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class NftPage extends StatefulWidget {
  const NftPage({super.key});

  @override
  State<NftPage> createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> with Func {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  late W3MService _w3mService;
  String walletConnectProjectId = dotenv.get("WALLET_CONNECT_PROJECT_ID");
  @override
  void initState() {
    super.initState();
    initializeState();
  }

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(
      source: imageSource,
      imageQuality: 30,
    );
    if (pickedFile != null) {
      setState(() {
        _image = XFile(
          pickedFile.path,
        ); //가져온 이미지를 _image에 저장
      });
    }
  }

  void initializeState() async {
    W3MChainPresets.chains.putIfAbsent('_chainId', () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: walletConnectProjectId,
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'flutterdapp://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }

  // void _onPersonalSign() async {
  //   await _w3mService.launchConnectedWallet();
  //
  //   await _w3mService.web3App!.request(
  //     topic: _w3mService.session!.topic,
  //     chainId: 'eip155:_$_chainId',
  //     request: SessionRequestParams(
  //       method: 'personal_sign',
  //       params: ['Sign this', _w3mService.session?.address],
  //     ),
  //   );
  // }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 300,
            height: 300,
            color: Colors.grey,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        W3MConnectWalletButton(service: _w3mService),
        const SizedBox(
          height: 16,
        ),
        W3MNetworkSelectButton(service: _w3mService),
        const SizedBox(
          height: 16,
        ),
        W3MAccountButton(service: _w3mService),
        const SizedBox(
          height: 16,
        ),

        Text(_w3mService.chainBalance.toString()),
        Text("wallet address"),
        // Text(_w3mService.session!.address.toString()),
        ElevatedButton(
          onPressed: () => getImage(ImageSource.camera),
          child: Text("이미지 피커 테스트"),
        ),
        _buildPhotoArea(),
        SizedBox(
          height: 40,
        ),
        ElevatedButton(
            onPressed: () => uploadToPinata(
                  _image,
                  "sample test",
                ),
            child: Text("이미지 업로드"))

        // ElevatedButton(onPressed: _onPersonalSign, child: child)
      ],
    );
  }
}

const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Sepolia',
  chainId: _chainId,
  namespace: 'eip155:$_chainId',
  tokenName: 'ETH',
  rpcUrl: 'https://rpc.sepolia.org/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io',
  ),
);
