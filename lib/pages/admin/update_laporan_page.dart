import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../../widgets/laporan_list.dart';
import '../../widgets/title_widget.dart';
import '../detail_laporan_screen.dart';
import 'detail_laporan_screen.dart';

class UpdateLaporanPage extends StatefulWidget {
  const UpdateLaporanPage({super.key});

  @override
  State<UpdateLaporanPage> createState() => _UpdateLaporanPageState();
}

class _UpdateLaporanPageState extends State<UpdateLaporanPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() {
    String uid = auth.currentUser!.uid;
    return firestore.collection("users").doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLaporan() {
    String uid = auth.currentUser!.uid;
    return firestore
        .collection("users")
        .doc(uid)
        .collection("laporan")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          "Update Laporan",
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
        ),
      ),
      body: Column(
        children: [
          kategoriLaporan(),
          // const LaporanList(
          //   title: "Pernyataan Laporan",
          // ),
          listLaporan()
        ],
      ),
    );
  }

  Widget kategoriLaporan() {
    return Container(
      padding: EdgeInsets.only(
          right: defaultMargin, left: defaultMargin, bottom: defaultMargin),
      color: background1Color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: defaultMargin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xff776CB3,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/Beranda.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Semua",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xff82A3F9,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/Terkirim.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Belum Diproses",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xffF7B57F,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/Diproses.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Diproses",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xff6FF574,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/Tuntas.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Tuntas",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listLaporan() {
    return StreamBuilder(
        stream: streamLaporan(),
        builder: (context, snapLaporan) {
          if (snapLaporan.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapLaporan.hasData) {
            var laporanList = snapLaporan.data!.docs;

            return Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(top: 22, left: 12, right: 12, bottom: 110),
                color: whiteColor,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(laporanList.length, (index) {
                      Map<String, dynamic> data = laporanList[index].data();

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailUpdateLaporanScreen(
                                  data: data,
                                ),
                              ));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 109,
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius:
                                  BorderRadius.circular(defaulBorderadius),
                              border: Border.all(
                                  width: 1, color: neutralGray3Color)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  width: 136,
                                  fit: BoxFit.cover,
                                  data['image'][0],
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: data['status'] ==
                                                "Laporan Diproses"
                                            ? orangeLight
                                            : data['status'] ==
                                                    "Laporan Telah Diselidiki"
                                                ? greenLight
                                                : blueLightColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Text(
                                          data['status'] == "Laporan Diproses"
                                              ? "Sementara Diproses"
                                              : data['status'] ==
                                                      "Laporan Telah Diselidiki"
                                                  ? "Selesai"
                                                  : "Belum Diproses",
                                          style: data['status'] ==
                                                  "Laporan Diproses"
                                              ? orangeTextStyle.copyWith(
                                                  fontSize: 8)
                                              : data['status'] ==
                                                      "Laporan Telah Diselidiki"
                                                  ? greenTextStyle.copyWith(
                                                      fontSize: 8)
                                                  : BlueTextStyle.copyWith(
                                                      fontSize: 8)),
                                    ),
                                    Text(
                                      data['kronologis'],
                                      style:
                                          blackTextStyle.copyWith(fontSize: 12),
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      "Somba Opu, Gowa",
                                      style: greyTertiaryTextStyle.copyWith(
                                          fontSize: 8),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            );
          } else {
            return Center(
              child: Text("Tidak dapat memuat data"),
            );
          }
        });
  }
}
