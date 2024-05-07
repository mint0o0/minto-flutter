import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:minto/src/components/loading_screen.dart';
import 'package:minto/src/fesitival_detail.dart';
import 'package:minto/src/utils/func.dart';


class FestivalMission extends StatelessWidget with Func {
  final Map<String, dynamic> festivalData;
  
  FestivalMission({required this.festivalData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(festivalData['name']),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: festivalData['missions'].length,
          itemBuilder: (context, index) {
            var mission = festivalData['missions'][index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '미션${index + 1}: ${mission['name']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    mission['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mission['imageList'].length,
                    itemBuilder: (context, index) {
                      var imageUrl = mission['imageList'][index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(imageUrl),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '미션장소: ${mission['location']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                if (index != festivalData['missions'].length - 1) Divider(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: () async {
              print("Create Nft");
              String imageUrl = await createImage("wide green barley with bright sunshine, like postcard, ((digital art 8K))");
  print("imageUrl: $imageUrl");
  await createAndSend(imageUrl, "고창 청보리밭 축제", "2024-05-02");
  print("미션완료 누름1");
             Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => LoadingScreen()),
).then((_) async {
  //String imageUrl = await createImage("wide green barley with bright sunshine, like postcard, ((digital art 8K))");
  //print("ima//geUrl: $imageUrl");
  //await createAndSend(imageUrl, "고창 청보리밭 축제", "2024-05-02");
  print("미션완료 누름1");
}
);
        
          print("미션완료 누름2");
            },
      
        backgroundColor: Colors.red,
        child: Text(
          '미션완료',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}