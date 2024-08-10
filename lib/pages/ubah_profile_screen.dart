import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../shared/theme.dart';

class UbahProfileScreen extends StatefulWidget {
  const UbahProfileScreen({super.key});

  @override
  State<UbahProfileScreen> createState() => _UbahProfileScreenState();
}

class _UbahProfileScreenState extends State<UbahProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() {
    String uid = auth.currentUser!.uid;
    return firestore.collection("users").doc(uid).snapshots();
  }

  late final Map<String, dynamic> user;
  TextEditingController nameC = TextEditingController();
  TextEditingController nomorC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  void updateProfile() async {
    String uid = auth.currentUser!.uid;
    if (nameC.text.isNotEmpty ||
        nomorC.text.isNotEmpty ||
        emailC.text.isNotEmpty) {
      await firestore.collection("users").doc(uid).update({
        "name": nameC.text,
        "nomor": nomorC.text,
        "email": emailC.text,
      });
    } else {
      try {} catch (e) {

        
      }
    }
    Navigator.pushReplacementNamed(context, '/main_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Ubah Profile",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data() ?? {};
              nameC.text = user['name'] ?? '';
              nomorC.text = user['nomor'] ?? '';
              emailC.text = user['email'] ?? '';
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: EdgeInsets.all(defaultMargin),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama Lengkap",
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12, bottom: 24),
                            height: 48,
                            child: TextField(
                              controller: nameC,
                              style: blackTextStyle.copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteColor,
                                hintText: "Masukkan Nama",
                                hintStyle: greyTertiaryTextStyle.copyWith(
                                    fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      defaulBorderadius), // Ganti dengan defaulBorderadius Anda
                                  borderSide:
                                      BorderSide.none, // Hilangkan border garis
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
                          Text(
                            "Nomor Telepon",
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12, bottom: 24),
                            height: 48,
                            child: TextField(
                              controller: nomorC,
                              keyboardType: TextInputType.phone,
                              style: blackTextStyle.copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteColor,
                                hintText: "Masukkan Nomor Telepon",
                                hintStyle: greyTertiaryTextStyle.copyWith(
                                    fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      defaulBorderadius), // Ganti dengan defaulBorderadius Anda
                                  borderSide:
                                      BorderSide.none, // Hilangkan border garis
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
                          Text(
                            "Email",
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12, bottom: 24),
                            height: 48,
                            child: TextField(
                              controller: emailC,
                              keyboardType: TextInputType.phone,
                              style: blackTextStyle.copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteColor,
                                hintText: "Masukkan Email",
                                hintStyle: greyTertiaryTextStyle.copyWith(
                                    fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      defaulBorderadius), // Ganti dengan defaulBorderadius Anda
                                  borderSide:
                                      BorderSide.none, // Hilangkan border garis
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateProfile();
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
                      "Perbaharui",
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
            );
          }),
    );
  }
}
