import 'package:google_maps_flutter/google_maps_flutter.dart';

class FestivalMarker {
  const FestivalMarker({
    required this.markerId,
    required this.position,
    required this.icon,
    required this.infoWindow,
    required this.title,
  });
  final MarkerId markerId;
  final LatLng position;
  final String icon;
  final InfoWindow infoWindow;
  final String title;
}
