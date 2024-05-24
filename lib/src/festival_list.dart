import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:minto/src/fesitival_detail.dart';
import 'package:minto/src/components/message_popup.dart';

void main() {
  runApp(const FestivalList());
}

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

class FestivalList extends StatefulWidget {
  const FestivalList({Key? key}) : super(key: key);

  @override
  _FestivalListState createState() => _FestivalListState();
}

class _FestivalListState extends State<FestivalList> {
  List<Festival> originalFestivals = [];
  List<Festival> festivals = [];
  int page = 0;
  bool isSearching = false;
  String? lastKeyword;
  String? lastCategory;

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

  void _searchFestivals(String keyword) async {
    final List<Festival> searchedFestivals = await searchFestivals(keyword);
    setState(() {
      festivals = searchedFestivals;
      isSearching = true;
      lastKeyword = keyword;
    });
  }

  void _filterByCategory(String category) async {
    final List<Festival> filteredFestivals =
        await categorizeFestivals(category);
    setState(() {
      festivals = filteredFestivals;
      isSearching = true;
      lastCategory = category;
    });
  }

  void _resetSearch() {
    setState(() {
      festivals = List.from(originalFestivals);
      isSearching = false;
      lastCategory = null;
      lastKeyword = null;
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
              if (isSearching && lastKeyword != null) ...[
                buildSearchResultHeader('$lastKeyword 검색결과:'),
              ],
              if (isSearching && lastCategory != null) ...[
                buildSearchResultHeader('$lastCategory 검색결과:'),
              ],
              if (!isSearching) ...[
                buildSectionTitle('추천 축제'),
                buildFestivalWidget(),
                buildSectionTitle('축제 탐색하기'),
              ],
              buildFestivalList(festivals),
              if (!isSearching) ...[
                buildLoadMoreButton(),
              ],
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
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 93, 167, 139),
          ),
          padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '어서오세요! 민토입니다♥',
                style: TextStyle(
                  fontFamily: 'GmarketSans',
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '축제를 즐겨보세요!',
                style: TextStyle(
                  fontFamily: 'GmarketSans',
                  color: const Color.fromARGB(166, 255, 255, 255),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 15),
              buildSearchField(),
              SizedBox(height: 27),
              buildCategoryButtons(),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onSubmitted: _searchFestivals,
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        buildSearchButton(),
      ],
    );
  }

  Widget buildSearchButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.search),
    );
  }

  Widget buildCategoryButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildCategoryButton('지역축제', 'local'),
        buildCategoryButton('음악축제', 'music'),
        buildCategoryButton('대학축제', 'university'),
        buildCategoryButton('전시회', 'fair'),
      ],
    );
  }

  Widget buildCategoryButton(String title, String category) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _filterByCategory(category);
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/${category}_3d_icon.png',
                width: 60,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontFamily: 'GmarketSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildSearchResultHeader(String resultText) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                resultText,
                style: TextStyle(
                  fontFamily: 'GmarketSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: _resetSearch,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    '원래대로',
                    style: TextStyle(
                      fontFamily: 'GmarketSans',
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'GmarketSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buildFestivalWidget() {
    final List<String> festivalList = [
      'assets/images/festival_example.png',
      'assets/images/festival_example_1.jpg',
      'assets/images/festival_example_2.jpg',
    ];

    return Container(
      height: 250,
      width: double.infinity,
      child: Swiper(
        itemCount: festivalList.length,
        autoplay: true,
        autoplayDelay: 3000,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                festivalList[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemHeight: 200,
        itemWidth: 400,
        layout: SwiperLayout.TINDER,
      ),
    );
  }

  Widget buildFestivalList(List<Festival> festivals) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
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
        Get.to(() => FestivalDetail(festivalId: festival.id));
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
        child: Text(
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
