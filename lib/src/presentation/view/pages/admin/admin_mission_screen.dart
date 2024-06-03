import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AdminMission extends StatefulWidget {
  final String festivalId = Get.arguments as String;

  AdminMission({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AdminMissionState();
  }
}

class _AdminMissionState extends State<AdminMission> {
  List missions = [];

  @override
  void initState() {
    super.initState();
    fetchFestivalData(widget.festivalId);
  }

  Future<void> fetchFestivalData(String festivalId) async {
    final response = await http
        .get(Uri.parse('http://3.34.98.150:8080/festival/$festivalId'));
    if (response.statusCode == 200) {
      // 본문을 UTF-8로 디코딩하여 문자열로 변환 후 JSON으로 디코딩
      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> festivalData = jsonDecode(responseBody);
      //print('Festival Data: $festivalData');
      setState(() {
        missions = festivalData["missions"];
        print(missions);
      });
      // return festivalData;
    } else {
      throw Exception('Failed to load festival data');
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<XFile> _images = [];

  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    setState(() {
      _images.clear();
      _images.addAll(selectedImages);
    });
  }

  void _showMissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Center(
                  child: Text(
                '미션 생성',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final List<XFile>? selectedImages =
                            await _picker.pickMultiImage();

                        if (selectedImages != null) {
                          setState(() {
                            _images.addAll(selectedImages);
                          });
                        }
                      },
                      child: Text('이미지 선택'),
                    ),
                    Wrap(
                      children: _images.map((image) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(image.path),
                            width: 50,
                            height: 50,
                          ),
                        );
                      }).toList(),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: "미션 제목"),
                    ),
                    TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(hintText: "장소"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Do something with the input values
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    print('Title: ${_titleController.text}');
                    print('Location: ${_locationController.text}');
                    print('Images: ${_images.map((e) => e.path).toList()}');
                    Navigator.of(context).pop();
                  },
                  child: Text('생성'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '미션 카드',
          style: TextStyle(
            fontFamily: 'GmarketSans',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: missions.length,
                itemBuilder: (context, index) {
                  var mission = missions[index];
                  var imageUrl = mission['imageList'][0];
                  // bool isCompleted = completedMissions.contains(index);

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0)),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '미션${index + 1}: ${mission['name']}\n${mission['location']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showMissionDialog,
        icon: const Icon(Icons.add),
        label: const Text(
          "미션 추가",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
