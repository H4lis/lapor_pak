import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../detail_berita_screen.dart';

class BeritaPage extends StatelessWidget {
  BeritaPage({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> streamBerita() {
    return firestore.collection("berita").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Berita",
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(
              top: defaultMargin, left: defaultMargin, right: defaultMargin),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: streamBerita(),
              builder: (context, snapBerita) {
                if (snapBerita.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapBerita.hasData) {
                  var listBerita = snapBerita.data!.docs;

                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        crossAxisSpacing: 12, // Spasi antar kolom
                        mainAxisSpacing: 12,
                      ),
                      itemCount: listBerita.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/upload_berita_screen");
                            },
                            child: Container(
                              height: 149,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.12), // Warna bayangan dengan 12% opacity
                                    offset: Offset(
                                        0, 2), // Posisi bayangan (x: 0, y: 2)
                                    blurRadius: 4, // Jarak blur
                                    spreadRadius: 0, // Penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_box_outlined,
                                      size: 42,
                                      color: blueTextColor,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Tambah Berita",
                                      style: BlueTextStyle.copyWith(
                                          fontSize: 14, fontWeight: medium),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          Map<String, dynamic> data =
                              listBerita[index - 1].data();
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailBeritaScren(data: data),
                                  ));
                            },
                            child: Container(
                              height: 149,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.12), // Warna bayangan dengan 12% opacity
                                    offset: Offset(
                                        0, 2), // Posisi bayangan (x: 0, y: 2)
                                    blurRadius: 4, // Jarak blur
                                    spreadRadius: 0, // Penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: double.infinity,
                                      data['image'],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    child: SizedBox(
                                      height: 56,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              data['judulBerita'],
                                              overflow: TextOverflow.clip,
                                              maxLines: 3,
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: medium),
                                            ),
                                          ),
                                          Text(
                                            data['createdAt'],
                                            overflow: TextOverflow.ellipsis,
                                            style: greyTextDisableTextStyle
                                                .copyWith(fontSize: 8),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      });
                }
                return Container(
                  height: 200,
                  width: 200,
                  color: Colors.amber,
                );
              })),
    );
  }
}
