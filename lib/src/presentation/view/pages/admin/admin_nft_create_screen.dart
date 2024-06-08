import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minto/src/presentation/view/pages/admin/widget/generated_image_box.dart';
import 'dart:io';

import 'package:minto/src/utils/func.dart';

class AdminNftCreate extends StatefulWidget {
  final String festivalId = Get.arguments as String;

  AdminNftCreate({super.key});
  @override
  State<StatefulWidget> createState() {
    return AdminNftCreateState();
  }
}

class AdminNftCreateState extends State<AdminNftCreate> with Func {
  String? aiImageOption;
  String drawingStyle = "cartoon style";
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
                      const Text("AI 이미지 생성 유무",
                          style: TextStyle(fontSize: 18)),
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
                          title: const Text("만화 그림체"),
                          leading: Radio<String>(
                            value: "cartoon style",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("사이버펑크 그림체"),
                          leading: Radio<String>(
                            value: "cyberpunk style",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("픽셀아트 그림체"),
                          leading: Radio<String>(
                            value: "pixelart style",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("현실적인 그림체"),
                          leading: Radio<String>(
                            value: "realistic style",
                            groupValue: drawingStyle,
                            onChanged: (String? value) {
                              setState(() {
                                drawingStyle = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // 여기에 로직 생성
                    print("---------------------");
                    var prompt = _themeController.text.toString();
                    print("(($drawingStyle))");
                    // if success goto image generate nft page
                    // message box? -> yes or no
                    // yes

                    showDialog(
                      context: context,
                      builder: (context) => FutureBuilder<String?>(
                          future: createImage("$prompt (($drawingStyle))"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AlertDialog(
                                content: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Center(child: Text("이미지 생성중")),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return AlertDialog(
                                title: Center(child: Text('Error')),
                                content: const Text('이미지 생성 실패'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasData) {
                              final imageUrl = snapshot.data!;
                              return GeneratedImageBox(
                                  festivalId: widget.festivalId,
                                  imageUrl: imageUrl,
                                  drawingStyle: drawingStyle);
                            } else {
                              return const SizedBox.shrink(); // 기본적으로 빈 위젯 반환
                            }
                          }),
                    );

                    // no
                    // else goto error popup
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
                  onPressed: () async {
                    // nft 생성 로직 만들기
                    // createNft(imageUrl, title, description)
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
