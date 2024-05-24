import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import 'admin_festival_detail_screen.dart';

class Festival {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final String location;
  final List<String> imageList;

  Festival({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.imageList,
  });

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      id: json['id'],
      name: json['name'],
      startTime: (json['startTime'] as String).split('T')[0],
      endTime: (json['endTime'] as String).split('T')[0],
      location: json['location'],
      imageList: List<String>.from(json['imageList']),
    );
  }
}

Future<List<Festival>> fetchFestivals(int page) async {
  final response =
      await http.get(Uri.parse('http://3.34.98.150:8080/festival?page=$page'));

  if (response.statusCode == 200) {
    final List<dynamic> data =
        jsonDecode(utf8.decode(response.bodyBytes))['content'];
    return data.map((json) => Festival.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load festivals');
  }
}

Future<List<Festival>> searchFestivals(String keyword) async {
  final response = await http.get(Uri.parse(
      'http://3.34.98.150:8080/festival?name=${Uri.encodeComponent(keyword)}'));
  if (response.statusCode == 200) {
    final List<dynamic> data =
        jsonDecode(utf8.decode(response.bodyBytes))['content'];
    return data.map((json) => Festival.fromJson(json)).toList();
  } else {
    throw Exception('Failed to search festivals');
  }
}

Future<List<Festival>> categorizeFestivals(String category) async {
  final response = await http.get(Uri.parse(
      'http://3.34.98.150:8080/festival?category=${Uri.encodeComponent(category)}'));

  if (response.statusCode == 200) {
    final List<dynamic> data =
        jsonDecode(utf8.decode(response.bodyBytes))['content'];
    return data.map((json) => Festival.fromJson(json)).toList();
  } else {
    throw Exception('Failed to categorize festivals');
  }
}

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  List<Festival> originalFestivals = [];
  List<Festival> festivals = [];
  int page = 0;
  bool isSearching = false;
  String? lastKeyword;
  String? lastCategory;

  String? _selectedValue;
  final List<String> _options = ['축제 관리', 'NFT 기념품 관리', '통계 확인'];

  @override
  void initState() {
    super.initState();
    _initialLoadFestivals();
  }

  Future<void> _initialLoadFestivals() async {
    page = 0;
    final List<Festival> fetchedFestivals = await fetchFestivals(page);
    setState(() {
      festivals = fetchedFestivals;
      originalFestivals = List.from(festivals);
      page++;
    });
    // _showMessagePopup();
  }

  Future<void> _loadFestivals() async {
    final List<Festival> fetchedFestivals = await fetchFestivals(page);
    setState(() {
      festivals.addAll(fetchedFestivals);
      originalFestivals.addAll(fetchedFestivals);
      page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              buildHeader(context),
              buildDropDownButton(context),
              buildFestivalList(festivals),
              buildLoadMoreButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      elevation: 12,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 93, 167, 139),
          ),
          padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
          alignment: Alignment.topLeft,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '관리자 축제 관리',
                style: TextStyle(
                  fontFamily: 'GmarketSans',
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropDownButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: DropdownButton<String>(
        value: _selectedValue,
        hint: const Text(
          "선택",
          style: TextStyle(color: Colors.black),
        ),
        items: _options
            .map((value) => DropdownMenuItem<String>(
                  child: Text(
                    value,
                  ),
                  value: value,
                ))
            .toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
        icon: const Padding(
          //Icon at tail, arrow bottom is default icon
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.arrow_circle_down_sharp),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.black,
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'GmarketSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buildFestivalList(List<Festival> festivals) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: festivals.length,
      itemBuilder: (context, index) {
        return buildFestivalCard(festivals[index]);
      },
    );
  }

  Widget buildFestivalCard(Festival festival) {
    return GestureDetector(
      onTap: () {
        print("페이지 이동");
        if (_selectedValue == "축제 관리") {
          Get.to(() => AdminFestivalDetail(festivalId: festival.id));
        } else if (_selectedValue == 'NFT 기념품 관리') {
        } else if (_selectedValue == '통계 확인') {}
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                festival.imageList.isNotEmpty ? festival.imageList[0] : '',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    festival.name,
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: '장소: ',
                      style: TextStyle(
                        fontFamily: 'GmarketSans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: festival.location,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: '시작일: ',
                      style: TextStyle(
                        fontFamily: 'GmarketSans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: festival.startTime,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: '종료일: ',
                      style: TextStyle(
                        fontFamily: 'GmarketSans',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: festival.endTime,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoadMoreButton() {
    return Center(
      child: TextButton(
        onPressed: _loadFestivals,
        child: const Text(
          '더 보기',
          style: TextStyle(
            fontFamily: 'GmarketSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
