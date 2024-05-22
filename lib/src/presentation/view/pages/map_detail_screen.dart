import 'package:flutter/material.dart';

import '../../../map_widget.dart';

class MapDetail extends StatelessWidget {
  const MapDetail({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.festivalId,
  });
  final String latitude;
  final String longitude;
  final String festivalId;

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      latitude: double.parse(latitude),
      longitude: double.parse(longitude),
      festivalId: festivalId,
    );
  }
}
