import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class AdminNftManage extends StatefulWidget {
  final String festivalId = Get.arguments as String;

  AdminNftManage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminNftMangeState();
  }
}

class AdminNftMangeState extends State<AdminNftManage> {
  List<Nft> nftList = [];

  @override
  void initState() {
    super.initState();
    _initialLoadNfts();
  }

  Future<void> _initialLoadNfts() async {
    final List<Nft> fetchNftList = await fetchNfts(widget.festivalId);
    setState(() {
      nftList = fetchNftList;
    });
    // _showMessagePopup();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "관리자 축제 NFT 관리",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 그리드의 열 개수
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.75,
            ),
            itemCount: nftList.length,
            itemBuilder: (context, index) {
              final nft = nftList[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.white,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        // 이미지가 카드를 넘어가는 것을 방지하기 위해 ClipRRect로 감싸줍니다.
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.0)), // 카드의 윗부분만 둥글게
                        child: Image.network(
                          nftList[index].image,
                          fit: BoxFit.cover, // 이미지가 카드에 꽉 차게 보이도록 설정
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nftList[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          SizedBox(height: 4),
                          Text(
                            nftList[index].description,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed("/admin/nft/create");
          },
          icon: const Icon(Icons.add),
          label: const Text(
            "NFT 추가",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class Nft {
  final String image;
  final String title;
  final String tokenId;
  final String tokenUri;
  final String description;
  Nft({
    required this.image,
    required this.title,
    required this.tokenId,
    required this.tokenUri,
    required this.description,
  });

  factory Nft.fromJson(Map<String, dynamic> json) {
    return Nft(
      image: json['image'],
      title: json['title'],
      tokenId: json['tokenId'],
      description: json['description'],
      tokenUri: json['tokenUri'].toString(),
    );
  }
}

Future<List<Nft>> fetchNfts(String festivalId) async {
  final response = await http
      .get(Uri.parse('http://3.34.98.150:8080/admin/festival/nft/$festivalId'));
  print(response.body.toString());
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    print(data.toString());
    print("tokenUri");
    return data.map((json) => Nft.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load nfts');
  }
}
