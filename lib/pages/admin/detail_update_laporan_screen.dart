// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lapor_pak/pages/admin/main_page_admin.dart';

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
  TextEditingController paparanHasilC = TextEditingController();
  TextEditingController jenisNarkobaC = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String uid = FirebaseAuth.instance.currentUser!.uid;
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
  Future<void> statusToProses() async {
    try {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPageAdmin(),
          ));

      CollectionReference<Map<String, dynamic>> collLaporan =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .collection("laporan");
      await collLaporan.doc(widget.data['id']).update(
        {
          "status": "Laporan Diproses",
        },
      );
    } catch (e) {
      print("Error updating status: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    print('kelaur =============');
  }

  Future<void> upHasilLap() async {
    if (paparanHasilC.text.isNotEmpty && jenisNarkobaC.text.isNotEmpty) {
      try {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPageAdmin(),
            ));
        CollectionReference<Map<String, dynamic>> collLaporan =
            await FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection("laporan");

        await collLaporan.doc(widget.data['id']).update(
          {
            "hasil": paparanHasilC.text,
            "jenis_narkoba": jenisNarkobaC.text,
          },
        );
        await collLaporan.doc(widget.data['id']).update(
          {
            "status": "Laporan Telah Diselidiki",
          },
        );
      } catch (e) {}
    } else {
      if (paparanHasilC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Paparan hasil penyelidikan harus diisi',
            ),
          ),
        );
      }
      if (jenisNarkobaC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Jenis Narkoba harus diisi',
            ),
          ),
        );
      }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Update Laporan",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.data['status'] != "Laporan Terkirim"
                ? updateBukti()
                : SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
                                    width:
                                        MediaQuery.of(context).size.width - 48,
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
                            fontWeight: medium,
                            fontSize: 16,
                            color: primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Kronologis",
                    style: blackTextStyle.copyWith(
                        fontWeight: medium, fontSize: 16),
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
                  widget.data['status'] == "Laporan Terkirim"
                      ? button()
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget updateBukti() {
    if (widget.data['status'] == "Laporan Telah Diselidiki") {
      paparanHasilC.text = widget.data['hasil'];
      jenisNarkobaC.text = widget.data['jenis_narkoba'];
    }
    ;
    return Container(
      width: double.infinity,
      color: Color(0xffF7F7FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  title: "Hasil Penyelidikan",
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: paparanHasilC,
                  maxLines: 5, // Set the number of lines for the text field
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaulBorderadius),
                        borderSide: BorderSide.none),
                    hintText: 'Paparan hasil penyelidikan yang telah selesai',
                    hintStyle: greyTertiaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor:
                        whiteColor, // Background color for the text field
                  ),
                  style: blackTextStyle.copyWith(fontSize: 14),
                ),
                TitleWidget(
                  title: "Jenis Narkoba",
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  height: 48,
                  child: TextField(
                    controller: jenisNarkobaC,
                    style: blackTextStyle.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: whiteColor,
                      hintText: "Jenis Narkoba",
                      hintStyle: greyTertiaryTextStyle.copyWith(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            defaulBorderadius), // Ganti dengan defaulBorderadius Anda
                        borderSide: BorderSide.none, // Hilangkan border garis
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            defaulBorderadius), // Sama dengan defaulBorderadius Anda
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            defaulBorderadius), // Sama dengan defaulBorderadius Anda
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                buttonUpdate()
              ],
            ),
          ),
        ],
      ),
    );
  }

  button() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () async {
            statusToProses();

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

  buttonUpdate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () async {
            upHasilLap();
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
            isLoading ? "Loading..." : "Update Laporan",
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
