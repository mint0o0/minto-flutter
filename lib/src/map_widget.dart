import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'data/datasource/festival/festival_marker_datasource.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.festivalId,
  }) : super(key: key);

  final double latitude;
  final double longitude;
  final String festivalId;
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  BitmapDescriptor boothIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor toiletIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  Set<Marker> setMarker = {};

  @override
  void initState() {
    _loadCustomMarker();

    super.initState();
  }

  Future<void> _loadCustomMarker() async {
    final Uint8List markerIcon =
        await _getBytesFromAsset('assets/images/map_marker/booth.png', 100);
    final Uint8List uint8ListBooth =
        await _getBytesFromAsset('assets/images/map_marker/booth.png', 100);
    final Uint8List uint8ListToilet =
        await _getBytesFromAsset('assets/images/map_marker/toilet.png', 100);
    customIcon = BitmapDescriptor.fromBytes(markerIcon);
    toiletIcon = BitmapDescriptor.fromBytes(uint8ListToilet);
    boothIcon = BitmapDescriptor.fromBytes(uint8ListBooth);

    setState(() {});
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  late Position _currentPosition;

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = LatLng(widget.latitude, widget.longitude);
    for (var m in festivalMarkers[widget.festivalId] ?? <dynamic>{}) {
      BitmapDescriptor icon = customIcon;
      if (m.icon == "booth") {
        icon = boothIcon;
      } else if (m.icon == "toilet") {
        icon = toiletIcon;
      }
      setMarker.add(
        Marker(
          markerId: m.markerId,
          position: m.position,
          infoWindow: m.infoWindow,
          icon: icon,
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // 왼쪽 둥근 모서리
              bottomRight: Radius.circular(20.0), // 오른쪽 둥근 모서리
            ),
          ),
          backgroundColor: Color.fromARGB(255, 93, 167, 139),
          title: Text("자세히 보기",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
          child: SafeArea(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 18.0,
              ),
              markers: setMarker,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var val = await getUserCurrentLocation();
            print(val.latitude);
            print(val.longitude);
            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(val.latitude, val.longitude),
              zoom: 14,
            );
            final GoogleMapController controller = mapController;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          },
        ));
  }
}
