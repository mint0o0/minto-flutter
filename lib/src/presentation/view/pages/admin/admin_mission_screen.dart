import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFestivalData(widget.festivalId);
  }

  Future<void> fetchFestivalData(String festivalId) async {
    final response = await http
        .get(Uri.parse('http://3.34.98.150:8080/festival/$festivalId'));
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> festivalData = jsonDecode(responseBody);
      setState(() {
        missions = festivalData["missions"];
      });
    } else {
      throw Exception('Failed to load festival data');
    }
  }

  final List<XFile> _images = [];
  List<String> imageList = [];

  Future<void> _selectDate(
      BuildContext context, bool isStart, StateSetter setState) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> _addMission() async {
    final String url =
        'http://3.34.98.150:8080/admin/festival/mission/${widget.festivalId}';
    final Map<String, dynamic> body = {
      'name': _titleController.text,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'startTime': _startDate != null
          ? _formatDate(_startDate!)
          : _formatDate(DateTime.now()),
      'endTime': _endDate != null
          ? _formatDate(_endDate!)
          : _formatDate(DateTime.now()),
      'imageList': imageList,
    };

    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      print('Mission added successfully');
    } else {
      print(response.statusCode);
      print(response.body);
      print('Failed to add mission: ${response.reasonPhrase}');
    }
  }

  Future<void> _uploadImage() async {
    if (_images.isNotEmpty) {
      final dio.FormData formData = dio.FormData();
      for (var image in _images) {
        formData.files.add(MapEntry(
          'file',
          await dio.MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        ));
      }
      final dio.Response response = await dio.Dio().post(
        'http://3.34.98.150:8080/admin/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        setState(() {
          for (var x in response.data) {
            imageList.add(x.toString());
          }
        });
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    }
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
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final List<XFile> selectedImages =
                            await _picker.pickMultiImage();

                        if (selectedImages != null) {
                          setState(() {
                            _images.addAll(selectedImages);
                          });
                        }
                      },
                      child: const Text('이미지 선택'),
                    ),
                    Wrap(
                      children: _images.map((image) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 1),
                          child: Image.file(
                            File(image.path),
                            width: 100,
                            height: 100,
                          ),
                        );
                      }).toList(),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: "미션 제목"),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(hintText: "설명"),
                    ),
                    TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(hintText: "장소"),
                    ),
                    ListTile(
                      title: Text(_startDate == null
                          ? '시작날짜'
                          : '시작날짜: ${_formatDate(_startDate!)}'),
                      trailing: const Icon(Icons.calendar_month),
                      onTap: () => _selectDate(context, true, setState),
                    ),
                    ListTile(
                      title: Text(_endDate == null
                          ? '끝나는 날짜'
                          : '끝나는 날짜: ${_formatDate(_endDate!)}'),
                      trailing: const Icon(Icons.calendar_month),
                      onTap: () => _selectDate(context, false, setState),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    await _uploadImage();
                    await _addMission();
                    Get.back();
                    Get.off(() => AdminMission(), arguments: widget.festivalId);
                  },
                  child: const Text('생성'),
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
        title: const Text(
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
