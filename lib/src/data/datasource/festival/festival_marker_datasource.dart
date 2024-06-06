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
};
