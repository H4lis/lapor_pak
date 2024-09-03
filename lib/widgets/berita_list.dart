import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lapor_pak/pages/detail_berita_screen.dart';

import '../shared/theme.dart';

class BeritaList extends StatelessWidget {
  BeritaList({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamBerita() {
 
    return firestore.collection("berita").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: streamBerita(),
        builder: (context, snapberita) {
          if (snapberita.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapberita.hasData) {
            var listBerita = snapberita.data!.docs;

            return Row(
                children: List.generate(
              listBerita.length,
              (index) {
                Map<String, dynamic> data = listBerita[index].data();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBeritaScren(data: data),
                        ));
                  },
                  child: Container(
                    width: 136,
                    height: 149,
                    margin: EdgeInsets.only(
                      left: index == 0 ? defaultMargin : 0,
                      right:
                          (index + 1) == listBerita.length ? defaultMargin : 8,
                      top: 16,
                      bottom: defaultMargin,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.12), // Warna bayangan dengan 12% opacity
                          offset: Offset(0, 2), // Posisi bayangan (x: 0, y: 2)
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
                            width: 136,
                            data['image'],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['judulBerita'],
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                                style: blackTextStyle.copyWith(fontSize: 10),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                data['isiBerita'],
                                overflow: TextOverflow.ellipsis,
                                style: greyTextDisableTextStyle.copyWith(
                                    fontSize: 8),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ));
          }
          return SizedBox();
        });
    ;
  }
}
