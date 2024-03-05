import 'package:bip32_bip44/dart_bip32_bip44.dart';
import 'package:bip39/bip39.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/foundation.dart';
import 'package:bip39/bip39.dart' as bip39;

import 'package:shared_preferences/shared_preferences.dart';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletProvider extends ChangeNotifier implements WalletAddressService {
  // Variable to store the private key
  String? privateKey;
  static const String _pathForPublicKey = "m/44'/60'/0'/0";
  static const String _pathForPrivateKey = "m/44'/60'/0'/0/0";

  // Load the private key from the shared preferences
  Future<void> loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateKey = prefs.getString('privateKey');
  }

  // set the private key in the shared preferences
  Future<void> setPrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
    this.privateKey = privateKey;
    notifyListeners();
  }

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Chain chain = _getChainByMnemonic(mnemonic);
    final ExtendedKey extendedKey = chain.forPath(_pathForPrivateKey);

    final privateKey = extendedKey.privateKeyHex().toString();
    print("Private Key: ${privateKey}");

    await prefs.setString('privateKey', privateKey);

    return privateKey;
  }

  // get Address
  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    print("address: ${address.hex.toString()}");
    return address;
  }

  /// Returns BIP32 Extended Public Key
  Future<String> getPublicEKey(String mnemonic) async {
    final Chain chain = _getChainByMnemonic(mnemonic);
    final ExtendedKey extendedKey = chain.forPath(_pathForPublicKey);
    return extendedKey.publicKey().toString();
  }

  /// Returns BIP32 Root Key
  Chain _getChainByMnemonic(String mnemonic) {
    final String seed = mnemonicToSeedHex(mnemonic); // Returns BIP39 Seed
    return Chain.seed(seed);
  }
}
