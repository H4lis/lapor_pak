// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:lapor_pak/widgets/title_widget.dart';

import '../../shared/theme.dart';

class DetailUpdateLaporanScreen extends StatefulWidget {
  Map<String, dynamic> data;
  DetailUpdateLaporanScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailUpdateLaporanScreen> createState() =>
      _DetailUpdateLaporanScreenState();
}

class _DetailUpdateLaporanScreenState extends State<DetailUpdateLaporanScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _marker = {};
  void _addMarker() {
    _marker.add(
      Marker(
        markerId: MarkerId('target_location'),
        position: LatLng(-5.4627627, 120.0194028),
        infoWindow: InfoWindow(
          title: 'My Location',
          snippet: 'This is the marked location',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed), // Merah
      ),
    );
  }

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-5.4627627, 120.0194028),
    zoom: 12.4,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addMarker();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Lapor",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: "Laporan dari ${widget.data['kategoriUnggahan']}",
              ),
              SizedBox(height: 12),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.data['image'] == ""
                      ? Image.asset(
                          fit: BoxFit.cover,
                          height: 176,
                          width: double.infinity,
                          "assets/images/lapor.png",
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              widget.data['image']?.length ?? 0,
                              (i) => Image.network(
                                widget.data['image'][i],
                                fit: BoxFit.cover,
                                height: 176,
                                width: MediaQuery.of(context).size.width - 48,
                              ),
                            ),
                          ),
                        )),
              TitleWidget(title: "Lokasi ${widget.data['kabupaten']}"),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                height: 164,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaulBorderadius),
                  color: greyTertiaryColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaulBorderadius),
                  child: GoogleMap(
                    mapType: MapType.terrain,
                    initialCameraPosition: _kGooglePlex,
                    markers: _marker, // Menambahkan marker ke peta
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),
              Text(
                // "QFXQ+QFH, Jl. Tun Abdul Razak, Romangpolong, Kec. Somba Opu, Kabupaten Gowa, Sulawesi Selatan",
                "${widget.data['lurah']}, ${widget.data['kecamatan']}, ${widget.data['kabupaten']}",
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    "Tindak Lanjut",
                    style: blackTextStyle.copyWith(
                        fontWeight: medium, fontSize: 16),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    widget.data['tindakLanjut'],
                    style: blackTextStyle.copyWith(
                        fontWeight: medium, fontSize: 16, color: primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Kronologis",
                style:
                    blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                widget.data['kronologis'] ?? 'Kronologis Tidak Diketahui',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              SizedBox(
                height: 30,
              ),
              button()
            ],
          ),
        ),
      ),
    );
  }
//
//
//
//
//
//
//

  button() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () async {
            if (!isLoading) {}
            ;
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  defaulBorderadius,
                ),
              ),
              minimumSize: Size(double.infinity, 48)),
          child: Text(
            isLoading ? "Loading..." : "Lanjut Diproses",
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
