import 'package:flutter/material.dart';
import 'package:minto/src/utils/func.dart';
import 'package:http/http.dart' as http;

class GeneratedImageBox extends StatefulWidget {
  final String imageUrl;
  final String festivalId;
  const GeneratedImageBox({
    Key? key,
    required this.imageUrl,
    required this.festivalId,
  }) : super(key: key);

  @override
  _GeneratedImageBoxState createState() => _GeneratedImageBoxState();
}

class _GeneratedImageBoxState extends State<GeneratedImageBox> with Func {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
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
        TextButton(
          onPressed: () async {
            final title = _titleController.text;
            final description = _descriptionController.text;
            // Do something with the title and description, e.g., print them
            print('Title: $title, Description: $description');
            // createNft
            await createNft(widget.imageUrl, title, description);
            // 축제 nft에 넣기
            Navigator.of(context).pop(); // 'NFT 생성' 버튼 클릭 시 창 닫기
          },
          child: const Text('NFT 생성'),
        ),
      ],
    );
  }
}
