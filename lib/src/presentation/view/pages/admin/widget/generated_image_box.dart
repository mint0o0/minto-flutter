import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view/pages/admin/admin_nft_manage_screen.dart';
import 'package:minto/src/utils/func.dart';
import 'package:http/http.dart' as http;

class GeneratedImageBox extends StatefulWidget {
  final String imageUrl;
  final String festivalId;
  final String drawingStyle;
  const GeneratedImageBox({
    Key? key,
    required this.imageUrl,
    required this.festivalId,
    required this.drawingStyle,
  }) : super(key: key);

  @override
  _GeneratedImageBoxState createState() => _GeneratedImageBoxState();
}

class _GeneratedImageBoxState extends State<GeneratedImageBox> with Func {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  String? _nftImageUrl;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> updateFestivalNft(
      String festivalId, Map<String, dynamic> requestBody) async {
    final url =
        Uri.parse('http://3.34.98.150:8080/admin/festival/$festivalId/nft');
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('NFT 업데이트 성공');
      } else {
        print('NFT 업데이트 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('예외 발생: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          '생성된 이미지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              widget.imageUrl,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '설명',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // '아니요' 버튼 클릭 시 창 닫기
          },
          child: const Text('아니요'),
        ),
        Container(
          child: _isLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: _createNft,
                  child: const Text('NFT 생성'),
                ),
        ),
      ],
    );
  }

  Future<void> _createNft() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final drawingStyle = widget.drawingStyle;

    setState(() {
      _isLoading = true;
    });

    try {
      print("try createNft");
      var response = await uploadToPinata(widget.imageUrl, title);
      final hash = response["IpfsHash"];
      final uploadUrl = "https://tan-electric-piranha-170.mypinata.cloud/ipfs/$hash";

      await createNft(uploadUrl, title, description, drawingStyle);
      var tokenId = await getNftsCount();

      final requestBody = {
        "image": uploadUrl,
        "description": description,
        "title": title,
        "tokenId": tokenId.toString(),
      };

      await updateFestivalNft(widget.festivalId, requestBody);
      Get.back();
      Get.back();
      Get.back();
      Get.to(() => AdminNftManage(), arguments: widget.festivalId);

      AdminNftManage.globalKey.currentState!.refreshNfts();

      print("createNft success");
    } catch (e) {
      print('NFT 생성 실패: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
