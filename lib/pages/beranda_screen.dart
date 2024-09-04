import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lapor_pak/shared/theme.dart';
import 'package:lapor_pak/widgets/berita_list.dart';
import 'package:lapor_pak/widgets/title_widget.dart';

import '../widgets/laporan_list.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection("users").doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context),
            beritaProduct(),
            Container(
              margin: EdgeInsets.only(left: defaultMargin, bottom: 16),
              child: const TitleWidget(
                title: "Pernyataan Laporan",
              ),
            ),
            const LaporanList(
              title: "",
            ),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamUser(),
        builder: (context, snapshot) {
          Map<String, dynamic> user = snapshot.data?.data() ?? {};
          String username = user['name'] ?? "s";
          return Container(
            height: 268,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF200F84), Color(0xFF120A41)],
                stops: [0.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Datang!",
                              style: whiteTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 20),
                            ),
                            Text(
                              username,
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/polis.png",
                              height: 64,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                "Laporkan orang atau wilayah yang terindikasi narkoba . . . ",
                                style: blackTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/lapor_screen');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  defaulBorderadius,
                                ),
                              ),
                              minimumSize: const Size(double.infinity, 32)),
                          child: Text(
                            "Laporkan sekarang",
                            style: whiteTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget pernyataanLap() {
    return Column(
      children: [],
    );
  }

  Widget beritaProduct() {
    return Container(
      width: double.infinity,
      color: background1Color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: defaultMargin),
            child: const TitleWidget(
              title: "Berita dan Informasi",
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BeritaList(),
          ),
        ],
      ),
    );
  }
}
