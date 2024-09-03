import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _marker = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-5.4627627, 120.0194028),
    zoom: 12.4,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addmarkers();
  }

  void _addmarkers() {
    _marker.add(Marker(
        markerId: MarkerId('target_location'),
        position: LatLng(-5.4627627, 120.0194028),
        infoWindow: InfoWindow(
            title: 'Ini lokasinya ayye', snippet: "Ini mi kodong lokasinya")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 12),
          height: 164,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                16.0), // ganti defaulBorderadius dengan 16.0 atau nilai yang kamu inginkan
            color: Colors.grey[
                300], // ganti greyTertiaryColor dengan Colors.grey[300] atau warna lain
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: _kGooglePlex,
                markers: _marker,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                }),
          ),
        ),
      ),
    );
  }
}
