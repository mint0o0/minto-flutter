import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minto/src/data/model/festival/festival_marker_model.dart';

const festivalMarkers = {
  FestivalMarker(
    markerId: MarkerId("1"),
    position: LatLng(37.504119763417485, 126.95657120036265),
    icon: "toilet",
    infoWindow: InfoWindow(
      title: "화장실",
      snippet: "건물 지하 1층",
    ),
    title: "title",
  ),
  FestivalMarker(
    markerId: MarkerId("2"),
    position: LatLng(37.50429763417485, 126.95557120036265),
    icon: "toilet",
    infoWindow: InfoWindow(
      title: "화장실",
      snippet: "건물 지상 1층",
    ),
    title: "화장실",
  ),
  FestivalMarker(
    markerId: MarkerId("3"),
    position: LatLng(37.50229763417485, 126.95547120036265),
    icon: "booth",
    infoWindow: InfoWindow(
      title: "부스",
      snippet: "건물 지상 1층",
    ),
    title: "title",
  ),
};
