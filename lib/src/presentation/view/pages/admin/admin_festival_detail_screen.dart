import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minto/src/festival_mission.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minto/src/presentation/view/pages/map_detail_screen.dart';

class AdminFestivalDetail extends StatelessWidget {
  final String festivalId = Get.arguments as String;

  AdminFestivalDetail({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchFestivalData() async {
    final response = await http.get(Uri.parse('http://3.34.98.150:8080/festival/$festivalId'));
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> festivalData = jsonDecode(responseBody);
      return festivalData;
    } else {
      throw Exception('Failed to load festival data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchFestivalData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Map<String, dynamic> festivalData = snapshot.data!;
          String name = festivalData['name'];
          String startTime = festivalData['startTime'].split('T')[0];
          String endTime = festivalData['endTime'].split('T')[0];
          List<String> imageList = List<String>.from(festivalData['imageList']);
          String description = festivalData['description'];
          String location = festivalData['location'] ?? '0';
          String price = festivalData['price'] ?? '0';
          String phoneNumber = festivalData['phone'] ?? '0';
          String instaID = festivalData['instagram'] ?? 'insta아이디 없음';
          String longitude = festivalData['longitude'] ?? '0';
          String latitude = festivalData['latitude'] ?? '0';
          String category = festivalData['category'] ?? '0';
          String host = festivalData['host'] ?? '0';
          Map<String, dynamic> festivalData1 = festivalData;

          return MaterialApp(
            title: 'Festival Detail',
            home: FestivalDetailScreen(
              festivalId: festivalId,
              category: category,
              name: name,
              startTime: startTime,
              endTime: endTime,
              imageList: imageList,
              description: description,
              location: location,
              price: price,
              phoneNumber: phoneNumber,
              instaID: instaID,
              longitude: longitude,
              latitude: latitude,
              host: host,
              festivalData1: festivalData1,
            ),
          );
        }
      },
    );
  }
}

class FestivalDetailScreen extends StatefulWidget {
  final String festivalId;
  final String category;
  final String name;
  final String startTime;
  final String endTime;
  final List<String> imageList;
  final String description;
  final String location;
  final String price;
  final String phoneNumber;
  final String instaID;
  final String longitude;
  final String latitude;
  final String host;
  final Map<String, dynamic> festivalData1;

  FestivalDetailScreen({
    required this.festivalId,
    required this.category,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.imageList,
    required this.description,
    required this.location,
    required this.price,
    required this.phoneNumber,
    required this.instaID,
    required this.longitude,
    required this.latitude,
    required this.host,
    required this.festivalData1,
  });

  @override
  _FestivalDetailScreenState createState() => _FestivalDetailScreenState();
}

class _FestivalDetailScreenState extends State<FestivalDetailScreen> {
  late bool isEditing;
  late bool showFullDescription;
  late bool showMap;

  late TextEditingController categoryController;
  late TextEditingController nameController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController priceController;
  late TextEditingController phoneNumberController;
  late TextEditingController instaIDController;
  late TextEditingController hostController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;

  late List<String> imageList;

  @override
  void initState() {
    super.initState();
    isEditing = false;
    showFullDescription = false;
    showMap = true;

    categoryController = TextEditingController(text: widget.category);
    nameController = TextEditingController(text: widget.name);
    startTimeController = TextEditingController(text: widget.startTime);
    endTimeController = TextEditingController(text: widget.endTime);
    descriptionController = TextEditingController(text: widget.description);
    locationController = TextEditingController(text: widget.location);
    priceController = TextEditingController(text: widget.price);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    instaIDController = TextEditingController(text: widget.instaID);
    hostController = TextEditingController(text: widget.host);
    latitudeController = TextEditingController(text: widget.latitude);
    longitudeController = TextEditingController(text: widget.longitude);

    imageList = List<String>.from(widget.imageList);
  }

  @override
  void dispose() {
    categoryController.dispose();
    nameController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    priceController.dispose();
    phoneNumberController.dispose();
    instaIDController.dispose();
    hostController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200.0,
              child: PageView.builder(
                itemCount: imageList.length + 1,
                itemBuilder: (context, index) {
                  if (index == imageList.length) {
                    return GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50.0,
                        ),
                      ),
                    );
                  }
                  return Stack(
                    children: [
                      Image.network(
                        imageList[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: 10.0,
                        right: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              imageList.removeAt(index);
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '상세설명',
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  isEditing
                      ? TextFormField(
                          controller: descriptionController,
                          maxLines: null,
                        )
                      : Text(
                          widget.description,
                          maxLines: showFullDescription ? null : 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 16.0,
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFullDescription = !showFullDescription;
                      });
                    },
                    child: Text(
                      showFullDescription ? '간략히' : '더보기',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'GmarketSans',
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '위치',
                              style: TextStyle(
                                fontFamily: 'GmarketSans',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            isEditing
                                ? TextFormField(
                                    controller: locationController,
                                    maxLines: null,
                                  )
                                : Text(
                                    widget.location,
                                    style: TextStyle(
                                      fontFamily: 'GmarketSans',
                                      fontSize: 16.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '가격',
                              style: TextStyle(
                                fontFamily: 'GmarketSans',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            isEditing
                                ? TextFormField(
                                    controller: priceController,
                                    maxLines: null,
                                  )
                                : Text(
                                    widget.price,
                                    style: TextStyle(
                                      fontFamily: 'GmarketSans',
                                      fontSize: 16.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '전화번호',
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  isEditing
                      ? TextFormField(
                          controller: phoneNumberController,
                          maxLines: null,
                        )
                      : Text(
                          widget.phoneNumber,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 16.0,
                          ),
                        ),
                  SizedBox(height: 16.0),
                  Text(
                    '인스타그램 ID',
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  isEditing
                      ? TextFormField(
                          controller: instaIDController,
                          maxLines: null,
                        )
                      : Text(
                          widget.instaID,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 16.0,
                          ),
                        ),
                  SizedBox(height: 16.0),
                  Text(
                    '주최자',
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  isEditing
                      ? TextFormField(
                          controller: hostController,
                          maxLines: null,
                        )
                      : Text(
                          widget.host,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 16.0,
                          ),
                        ),
                  SizedBox(height: 16.0),
                  Text(
                    '위도',
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  isEditing
                      ? TextFormField(
                          controller: latitudeController,
                          maxLines: null,
                        )
                      : Text(
                          widget.latitude,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 16.0,
                          ),
                        ),
                  SizedBox(height: 16.0),
                  Text(
                    '경도',
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  isEditing
                      ? TextFormField(
                          controller: longitudeController,
                          maxLines: null,
                        )
                      : Text(
                          widget.longitude,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 16.0,
                          ),
                        ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  if (!isEditing)
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                    
                      child: Text('관련 퀘스트 보러가기'),
                    ),
                ],
              ),
            ),
            if (showMap)
              SizedBox(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.parse(widget.latitude),
                      double.parse(widget.longitude),
                    ),
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('festivalLocation'),
                      position: LatLng(
                        double.parse(widget.latitude),
                        double.parse(widget.longitude),
                      ),
                    ),
                  },
                ),
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isEditing = !isEditing;
            if (!isEditing) {
              // Save changes
              _saveChanges();
            }
          });
        },
        child: Icon(isEditing ? Icons.save : Icons.edit),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(pickedFile.path),
      });

      final dio.Response response = await dio.Dio().post(
        'http://3.34.98.150:8080/festival/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        setState(() {
          imageList.add(response.data['url']);
        });
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    }
  }

  Future<void> _saveChanges() async {
    Map<String, dynamic> updatedData = {
      'category': categoryController.text,
      'name': nameController.text,
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
      'description': descriptionController.text,
      'location': locationController.text,
      'price': priceController.text,
      'phoneNumber': phoneNumberController.text,
      'instaID': instaIDController.text,
      'host': hostController.text,
      'latitude': latitudeController.text,
      'longitude': longitudeController.text,
      'imageList': imageList,
    };

    final response = await http.put(
      Uri.parse('http://3.34.98.150:8080/festival/${widget.festivalId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      print('Festival updated successfully');
    } else {
      print('Failed to update festival with status: ${response.statusCode}');
    }
  }
}
