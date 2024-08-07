import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';

import '../widgets/title_widget.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() {
    String uid = auth.currentUser!.uid;
    return firestore.collection("users").doc(uid).snapshots();
  }

  void logout() async {
    await auth.signOut();
    Navigator.pushNamed(context, '/login_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background1Color,
      body: StreamBuilder(
          stream: streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data() ?? {};

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(context, user),
                  Padding(
                    padding: EdgeInsets.all(defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          title: "Pengaturan Akun",
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/ubah_password_screen');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.circular(defaulBorderadius),
                            ),
                            margin: EdgeInsets.only(bottom: 24, top: 24),
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/Pass.png",
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Ubah Password",
                                  style: blackTextStyle.copyWith(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                          ),
                          margin: EdgeInsets.only(bottom: 24),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/Tentang.png",
                                width: 24,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Tentang Aplikasi LaporPak",
                                style: blackTextStyle.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                          ),
                          margin: EdgeInsets.only(bottom: 24),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/Syarat.png",
                                width: 24,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Syarat & Ketentuan",
                                style: blackTextStyle.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                          ),
                          margin: EdgeInsets.only(bottom: 24),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/Privasi.png",
                                width: 24,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Kebijakan Privasi",
                                style: blackTextStyle.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            logout();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius:
                                  BorderRadius.circular(defaulBorderadius),
                            ),
                            margin: EdgeInsets.only(bottom: 24),
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/Logout.png",
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Keluar",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, color: Color(0xffFC2E2E)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget header(BuildContext context, Map<String, dynamic> user) {
    return Container(
      padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 40,
          bottom: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF200F84),
            Color(0xFF120A41),
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${user['nomor']}",
                  style:
                      whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
                Text(
                  "${user['email']}",
                  style: whiteTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/ubah_profile_screen");
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(72, 23),
              backgroundColor: primaryColor,
            ),
            child: Text(
              "Ubah",
              style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
