import 'package:flutter/material.dart';
import 'package:minto/src/misson_detail.dart';
import 'package:http/http.dart' as http;
import 'package:minto/src/utils/func.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
class FestivalMission extends StatefulWidget {
  final Map<String, dynamic> festivalData;

  FestivalMission({required this.festivalData});

  @override
  _FestivalMissionState createState() => _FestivalMissionState();
}

class _FestivalMissionState extends State<FestivalMission> with Func{
  List<int> completedMissions = [];
  bool showNFTButton = false;

  @override
  void initState() {
    super.initState();
    fetchCompletedMissions();
    fetchNFTButtonVisibility();
  }

  Future<void> fetchCompletedMissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accesstoken') ?? '';
    final response = await http.get(
      Uri.parse('http://3.34.98.150:8080/member/mission/complete/${widget.festivalData['id']}'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        completedMissions = List<int>.from(data['mission']);
      });
    } else {
      throw Exception('Failed to load completed missions');
    }
  }

  Future<void> fetchNFTButtonVisibility() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accesstoken') ?? '';
    final response = await http.get(
      Uri.parse('http://3.34.98.150:8080/member/mission/complete/all/${widget.festivalData['id']}'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      //log("mission/complete/all에서 200뜸");
      final data = json.decode(response.body);
      setState(() {
        showNFTButton = data == 2;
      });
    } else {
      throw Exception('Failed to check NFT button visibility');
    }
  }

 void issueNFT()  async {
  String url = 'http://3.34.98.150:8080/festival/${widget.festivalData['id']}/nft/count';

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accesstoken') ?? '';
  
  // GET 요청 보내기
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    // count 값 가져오기
    int count = int.parse(response.body);

    // count를 BigInt로 변환
    BigInt bigIntCount = BigInt.from(count);

    // sendNft 호출
    sendNft(bigIntCount);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('festivalid');

    // PUT 요청 보내기
    final putResponse = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (putResponse.statusCode == 200) {
      print('NFT 발급 카운트 업데이트 성공');
    } else {
      print('NFT 발급 카운트 업데이트 실패: ${putResponse.statusCode}');
    }
  } else {
    print('NFT 발급 카운트 조회 실패: ${response.statusCode}');
  }
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
                itemCount: widget.festivalData['missions'].length,
                itemBuilder: (context, index) {
                  var mission = widget.festivalData['missions'][index];
                  var imageUrl = mission['imageList'][0];
                  bool isCompleted = completedMissions.contains(index);

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MissionDetailPage(missionData: mission)),
                          ).then((value) {
                            // 상세 페이지에서 돌아올 때 데이터를 다시 로드
                            fetchCompletedMissions();
                            fetchNFTButtonVisibility();
                          });
                          print('미션 클릭됨');
                        },
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
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
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            if (isCompleted)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/completed_mark.webp',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (showNFTButton)
              Container(
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  child: Material(
    color: Colors.green,
    elevation: 4.0,
    child: InkWell(
      onTap: () {
        issueNFT();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        alignment: Alignment.center,
        child: Text(
          'NFT발급',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
