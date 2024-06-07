import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minto/src/data/model/festival/festival_marker_model.dart';

const Map<String, Set<FestivalMarker>> festivalMarkers = {
  "6632093c788e207ba11e5acf": {
    FestivalMarker(
      markerId: MarkerId("1"),
      position: LatLng(36.50115775387686, 126.3367717613861),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "화장실",
        snippet: "건물 지하 1층",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("2"),
      position: LatLng(36.50105775387686, 126.3366717613861),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "화장실",
        snippet: "건물 지상 1층",
      ),
      title: "화장실",
    ),
    FestivalMarker(
      markerId: MarkerId("3"),
      position: LatLng(36.50102775387686, 126.3366617613861),
      icon: "booth",
      infoWindow: InfoWindow(
        title: "부스",
        snippet: "건물 지상 1층",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("4"),
      position: LatLng(36.50145775387686, 126.3368717613861),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "화장실",
        snippet: "건물 지상 2층",
      ),
      title: "title",
    ),
  },
  "66321b54788e207ba11e5ada": {
    FestivalMarker(
      markerId: MarkerId("1"),
      position: LatLng(37.100977, 129.009635),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "화장실",
        snippet: "건물 지하 1층",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("2"),
      position: LatLng(37.101977, 129.009635),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "화장실",
        snippet: "건물 지상 1층",
      ),
      title: "화장실",
    ),
    FestivalMarker(
      markerId: MarkerId("3"),
      position: LatLng(37.1012277, 129.009135),
      icon: "booth",
      infoWindow: InfoWindow(
        title: "부스",
        snippet: "건물 지상 1층",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("4"),
      position: LatLng(37.1013277, 129.008235),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "화장실",
        snippet: "건물 지상 2층",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("5"),
      position: LatLng(37.102, 129.008235),
      icon: "information",
      infoWindow: InfoWindow(
        title: "푸드트럭",
        snippet: "건물 지상 2층",
      ),
      title: "title",
    ),
  },
  "6632093c788e207ba11e4abf": {
    FestivalMarker(
      markerId: MarkerId("1"),
      position: LatLng(37.50483178661099,  126.95719847571964),
      icon: "booth",
      infoWindow: InfoWindow(
        title: "중앙사랑 부스",
        snippet: "인스타그램 팔로우 확인후 푸앙이 기념 추첨 이벤트",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("2"),
      position: LatLng(37.50500301850901, 126.95731147512343),
      icon: "booth",
      infoWindow: InfoWindow(
        title: "소개팅부스",
        snippet: "쪽지로 새로운 인연만나기",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("3"),
      position: LatLng(37.503646919599184, 126.95707474750724),
      icon: "information",
      infoWindow: InfoWindow(
        title: "안내처",
        snippet: "208관 1층로비",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("4"),
      position: LatLng(37.50686481443856, 126.96083347901332 ),
      icon: "hospital",
      infoWindow: InfoWindow(
        title: "중앙대학교병원",
        snippet: "지상1층 응급실",
      ),
      title: "title",
    ),
    
    FestivalMarker(
      markerId: MarkerId("5"),
      position: LatLng(37.50496447654244, 126.95662725960706 ),
      icon: "foodtruck",
      infoWindow: InfoWindow(
        title: "소고기 불초밥",
        snippet: "8피스: 9000원",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("6"),
      position: LatLng(37.50490821554546,126.95676866342501),
      icon: "foodtruck",
      infoWindow: InfoWindow(
        title: "타코야끼",
        snippet: "10알: 5000원, 20알: 9000원",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("7"),
      position: LatLng(37.50487445886569, 126.95685350561399),
      icon: "foodtruck",
      infoWindow: InfoWindow(
        title: "야끼소바",
        snippet: "야끼소바 10000원",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("8"),
      position: LatLng(37.50513357407045,126.95706258660239),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "본관",
        snippet: "지상 1층, 학생증 필요",
      ),
      title: "title",
    ),
    FestivalMarker(
      markerId: MarkerId("9"),
      position: LatLng(37.50378162763475, 126.95587303264486),
      icon: "toilet",
      infoWindow: InfoWindow(
        title: "310관",
        snippet: "지상 1층, 학생증 불필요",
      ),
      title: "title",
    ),
  },
};
