import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminNftCreate extends StatefulWidget {
  const AdminNftCreate({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminNftCreateState();
  }
}

class AdminNftCreateState extends State<AdminNftCreate> {
  String? aiImageOption;
  String? drawingStyle;
  final TextEditingController _themeController = TextEditingController();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("AI 이미지 생성 유무", style: TextStyle(fontSize: 18)),
                      ListTile(
                        title: const Text("AI로 이미지를 생성하겠습니다"),
                        leading: Radio<String>(
                          value: "AI",
                          groupValue: aiImageOption,
                          onChanged: (String? value) {
                            setState(() {
                              aiImageOption = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("원래 가져온 이미지가 있습니다"),
                        leading: Radio<String>(
                          value: "Existing",
                          groupValue: aiImageOption,
                          onChanged: (String? value) {
                            setState(() {
                              aiImageOption = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (aiImageOption == "AI") ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("주제 입력", style: TextStyle(fontSize: 18)),
                        TextField(
                          controller: _themeController,
                          decoration: const InputDecoration(
                            hintText: "주제를 입력하세요",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("그림체 선택", style: TextStyle(fontSize: 18)),
                        ListTile(
                          title: const Text("cartoon style"),
                          leading: Radio<String>(
                            value: "cartoon",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("cyberpunk style"),
                          leading: Radio<String>(
                            value: "cyberpunk",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("pixelart style"),
                          leading: Radio<String>(
                            value: "pixelart",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("realistic style"),
                          leading: Radio<String>(
                            value: "realistic",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement AI image generation logic here
                  },
                  child: const Text("AI로 이미지 생성하기"),
                ),
              ],
              if (aiImageOption == "Existing") ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("이미지 업로드", style: TextStyle(fontSize: 18)),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text("이미지 선택"),
                        ),
                        if (_imageFile != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(File(_imageFile!.path)),
                          ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement NFT creation logic here
                  },
                  child: const Text("NFT 생성하기"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const AdminNftCreate());
}
