import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminFestivalDetail extends StatelessWidget {
  final String festivalId;

  AdminFestivalDetail({Key? key, required this.festivalId}) : super(key: key);

  Future<Map<String, dynamic>> fetchFestivalData() async {
    final response = await http
        .get(Uri.parse('http://3.34.98.150:8080/festival/$festivalId'));
    if (response.statusCode == 200) {
      // 본문을 UTF-8로 디코딩하여 문자열로 변환 후 JSON으로 디코딩
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
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
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
          bool festivalInProgress =
              DateTime.now().isAfter(DateTime.parse(startTime)) &&
                  DateTime.now().isBefore(DateTime.parse(endTime));

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
              festivalInProgress: festivalInProgress,
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
  final bool festivalInProgress;
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
    required this.festivalInProgress,
    required this.longitude,
    required this.latitude,
    required this.host,
    required this.festivalData1,
  });

  @override
  _FestivalDetailScreenState createState() => _FestivalDetailScreenState();
}

class _FestivalDetailScreenState extends State<FestivalDetailScreen> {
  bool showFullDescription = false;
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController instaIDController = TextEditingController();
  TextEditingController hostController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    descriptionController.text = widget.description;
    locationController.text = widget.location;
    priceController.text = widget.price;
    phoneNumberController.text = widget.phoneNumber;
    instaIDController.text = widget.instaID;
    hostController.text = widget.host;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: const Color.fromARGB(255, 93, 167, 139),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                '축제 상세 정보',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'GmarketSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.network(
                widget.imageList[0],
                fit: BoxFit.cover,
              ),
            ),
            automaticallyImplyLeading: false,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0), // 왼쪽 둥근 모서리
                bottomRight: Radius.circular(20.0), // 오른쪽 둥근 모서리
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0 * 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 16.0),
                Text(
                  widget.category,
                  style: TextStyle(
                    fontFamily: 'GmarketSans',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                isEditing
                    ? TextFormField(
                        controller: nameController,
                      )
                    : Text(
                        widget.name,
                        style: TextStyle(
                          fontFamily: 'GmarketSans',
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                SizedBox(height: 8.0),
                widget.festivalInProgress
                    ? Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '축제 진행중',
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 8.0),
                Text(
                  '${widget.startTime} ~ ${widget.endTime}',
                  style: TextStyle(
                    fontFamily: 'GmarketSans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Image.network(
                          widget.imageList[index],
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: isEditing
                      ? TextFormField(
                          controller: descriptionController,
                        )
                      : Text(
                          widget.description,
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                          textAlign: TextAlign.justify,
                          overflow: showFullDescription
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          maxLines: showFullDescription ? null : 3,
                        ),
                ),
                SizedBox(height: 8.0),
                widget.description.length > 100
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            showFullDescription = !showFullDescription;
                          });
                        },
                        child: Text(
                          showFullDescription ? '접기' : '더보기',
                          style: TextStyle(
                              fontFamily: 'GmarketSans', color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                _buildInfoRow(
                  iconPath: 'assets/images/calendar_3d_icon.png',
                  text: '${widget.startTime} ~ ${widget.endTime}',
                ),
                SizedBox(height: 6.0),
                isEditing
                    ? _buildEditableInfoRow(
                        iconPath: 'assets/images/point_3d_icon.png',
                        textController: locationController,
                        text: widget.location,
                      )
                    : _buildInfoRow(
                        iconPath: 'assets/images/point_3d_icon.png',
                        text: widget.location,
                      ),
                SizedBox(height: 6.0),
                isEditing
                    ? _buildEditableInfoRow(
                        iconPath: 'assets/images/coin_3d_icon.png',
                        textController: priceController,
                        text: widget.price,
                      )
                    : _buildInfoRow(
                        iconPath: 'assets/images/coin_3d_icon.png',
                        text: widget.price,
                      ),
                SizedBox(height: 6.0),
                isEditing
                    ? _buildEditableInfoRow(
                        iconPath: 'assets/images/host_3d_icon.webp',
                        textController: hostController,
                        text: widget.host,
                      )
                    : _buildInfoRow(
                        iconPath: 'assets/images/host_3d_icon.webp',
                        text: widget.host,
                      ),
                SizedBox(height: 6.0),
                isEditing
                    ? _buildEditableInfoRow(
                        iconPath: 'assets/images/phonecall_3d_icon.webp',
                        textController: phoneNumberController,
                        text: widget.phoneNumber,
                      )
                    : _buildInfoRow(
                        iconPath: 'assets/images/phonecall_3d_icon.webp',
                        text: widget.phoneNumber,
                      ),
                SizedBox(height: 6.0),
                isEditing
                    ? _buildEditableInfoRow(
                        iconPath: 'assets/images/insta_3d_icon.png',
                        textController: instaIDController,
                        text: widget.instaID,
                      )
                    : _buildInfoRow(
                        iconPath: 'assets/images/insta_3d_icon.png',
                        text: widget.instaID,
                      ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: _navigateToMissionPage,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 93, 167, 139),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        '미션 상세 정보',
                        style: TextStyle(
                          fontFamily: 'GmarketSans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () => {
                    // Get.to(() => NftScreen(festivalId: widget.festivalId, name: widget.name, description: widget.description)),
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 93, 167, 139),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        '축제 NFT 관리',
                        style: TextStyle(
                          fontFamily: 'GmarketSans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Divider(),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: isEditing
          ? FloatingActionButton(
              onPressed: _saveFestivalDetail,
              child: Icon(Icons.save),
              backgroundColor: Colors.green,
            )
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
              child: Icon(Icons.edit),
              backgroundColor: Colors.blue,
            ),
    );
  }

  Widget _buildInfoRow({required String iconPath, required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 32.0,
            height: 32.0,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontFamily: 'GmarketSans', fontSize: 16.0),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInfoRow({
    required String iconPath,
    required TextEditingController textController,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 32.0,
            height: 32.0,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: isEditing
                ? TextFormField(
                    controller: textController,
                  )
                : Text(
                    text,
                    style: TextStyle(fontFamily: 'GmarketSans', fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
          ),
        ],
      ),
    );
  }

  void _navigateToMissionPage() {
    // Get.to(FestivalMission(festivalData: widget.festivalData1));
  }

  Future<void> _saveFestivalDetail() async {
    String name = nameController.text;
    String description = descriptionController.text;
    String location = locationController.text;
    String price = priceController.text;
    String phoneNumber = phoneNumberController.text;
    String instaID = instaIDController.text;
    String host = hostController.text;

    final response = await http.put(
        // Uri.parse('http://3.34.98.150:8080/admin/${widget.festivalId}/update'),
        Uri.parse('localhost:8080/admin/${widget.festivalId}/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'description': description,
          'location': location,
          'price': price,
        }));

    if (response.statusCode == 200) {
      isEditing = false;
    } else {
      Get.snackbar('Error', 'Failed to update festival detail');
    }
  }
}
