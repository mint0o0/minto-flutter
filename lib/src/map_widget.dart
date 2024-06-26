import 'dart:developer';
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
  BitmapDescriptor hospitalIcon= BitmapDescriptor.defaultMarker;
  BitmapDescriptor informationIcon= BitmapDescriptor.defaultMarker;
  BitmapDescriptor foodtruckIcon= BitmapDescriptor.defaultMarker;
  Set<Marker> setMarker = {};

  @override
  void initState() {
    _loadCustomMarker();

    super.initState();
  }

  Marker _markers = Marker(
    markerId: MarkerId("current location"),
  );

  Future<void> _loadCustomMarker() async {
    final Uint8List markerIcon =
        await _getBytesFromAsset('assets/images/map_marker/booth.png', 100);
    final Uint8List uint8ListBooth =
        await _getBytesFromAsset('assets/images/map_marker/booth.png', 100);
    final Uint8List uint8ListToilet =
        await _getBytesFromAsset('assets/images/map_marker/toilet.png', 100);
    final Uint8List uint8Listhospital =await _getBytesFromAsset('assets/images/map_marker/hospital.png', 100);
    final Uint8List uint8Listinformation =await _getBytesFromAsset('assets/images/map_marker/information.png', 100);
    final Uint8List uint8Listfoodtruck =await _getBytesFromAsset('assets/images/map_marker/foodtruck.png', 100);
    customIcon = BitmapDescriptor.fromBytes(markerIcon);
    toiletIcon = BitmapDescriptor.fromBytes(uint8ListToilet);
    boothIcon = BitmapDescriptor.fromBytes(uint8ListBooth);
    hospitalIcon=BitmapDescriptor.fromBytes(uint8Listhospital);
    informationIcon=BitmapDescriptor.fromBytes(uint8Listinformation);
    foodtruckIcon=BitmapDescriptor.fromBytes(uint8Listfoodtruck);
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
      } else if(m.icon=="hospital"){
        icon=hospitalIcon;
      } else if(m.icon=="information"){
        icon=informationIcon;
      } else if(m.icon=="foodtruck"){
        icon=foodtruckIcon;
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
    setMarker.add(_markers);
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
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
          log(val.latitude.toString());
          log(val.longitude.toString());
          _markers = Marker(
            markerId: const MarkerId('current location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: LatLng(val.latitude, val.longitude),
            infoWindow: const InfoWindow(
              title: '현재 위치',
            ),
          );
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
        child: const Icon(
          Icons.my_location,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
