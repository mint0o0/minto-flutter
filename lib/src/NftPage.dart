import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class NftPage extends StatefulWidget {
  const NftPage({super.key});

  @override
  State<NftPage> createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> {
  late W3MService _w3mService;

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() async {
    W3MChainPresets.chains.putIfAbsent('_chainId', () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: 'fb43f9d98cb59b2fe2f5d39ba1ef2175',
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
