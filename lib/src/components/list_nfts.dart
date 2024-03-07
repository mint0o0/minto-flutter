import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NFTListPage extends StatefulWidget {
  final String address;
  final String chain;

  const NFTListPage({
    Key? key,
    required this.address,
    required this.chain,
  }) : super(key: key);

  @override
  _NFTListPageState createState() => _NFTListPageState();
}

class _NFTListPageState extends State<NFTListPage> {
  List<dynamic> _nftList = [];

  @override
  void initState() {
    super.initState();
    _loadNFTList();
  }

  Future<void> _loadNFTList() async {
    var options = BaseOptions(
        baseUrl: 'http://10.210.61.97:5002',
        headers: {'Content-Type': 'application/json'},
        queryParameters: {'address': widget.address, 'chain': widget.chain});
    final dio = Dio(options);
    final response = await dio.get('/get_user_nfts');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.data);
      setState(() {
        _nftList = jsonData['result'];
        print(response.data);
      });
    } else {
      throw Exception('Failed to load NFT list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT List Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var nft in _nftList)
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${nft['name']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 200, // adjust the height as needed
                      child: Image.network(
                        nft['normalized_metadata']['image'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      '${nft['normalized_metadata']['description']}',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
