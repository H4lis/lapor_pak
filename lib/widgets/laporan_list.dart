import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lapor_pak/pages/detail_berita_screen.dart';
import 'package:lapor_pak/pages/detail_laporan_screen.dart';
import 'package:lapor_pak/widgets/laporan_card.dart';

import '../shared/theme.dart';
import 'title_widget.dart';

class LaporanList extends StatefulWidget {
  final String title;
  const LaporanList({super.key, required this.title});

  @override
  State<LaporanList> createState() => _LaporanListState();
}

class _LaporanListState extends State<LaporanList> {
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

            return Container(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 110),
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
                              builder: (context) => DetailLaporanScreen(
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
                            border:
                                Border.all(width: 1, color: neutralGray3Color)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                width: 136,
                                fit: BoxFit.cover,
                                data['image'],
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
                                      color: blueLightColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      "Laporan Terkirim",
                                      style:
                                          BlueTextStyle.copyWith(fontSize: 8),
                                    ),
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
            );
          } else {
            return Center(
              child: Text("Tidak dapat memuat data"),
            );
          }
        });
    ;
  }
}
