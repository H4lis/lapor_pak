import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class UploadBeritaScreen extends StatefulWidget {
  UploadBeritaScreen({super.key});

  @override
  State<UploadBeritaScreen> createState() => _UploadBeritaScreenState();
}

class _UploadBeritaScreenState extends State<UploadBeritaScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController judulC = TextEditingController();
  TextEditingController isiBeritaC = TextEditingController();
  bool isLoading = false;
  XFile? selectedImages;

  void imageAddd() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImages = pickedFile;
      });
    }
  }

  Future<void> upBerita() async {
    if (selectedImages != null &&
        judulC.text.isNotEmpty &&
        isiBeritaC.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        CollectionReference<Map<String, dynamic>> collBerita =
            await firestore.collection("berita");

        DateTime now = DateTime.now();
        String formattedDate =
            DateFormat('d MMMM yyyy || HH : mm').format(now) + ' WIB';
        print("==============");
        print("==============");
        print(formattedDate);

        String fullDateTimeString = now.toString();
        String dateAndTime = fullDateTimeString.split('.')[0];
        String fileName =
            '${dateAndTime}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        String filePath = 'berita/$fileName';
        String imageUrls;
        File imageFile = File(selectedImages!.path);
        await storage.ref(filePath).putFile(imageFile);
        String urlImage = await storage.ref(filePath).getDownloadURL();

        await collBerita.doc(dateAndTime).set({
          "image": urlImage,
          "judulBerita": judulC.text,
          "isiBerita": isiBeritaC.text,
          "createdAt": formattedDate,
        });

        Navigator.pushNamed(context, "/main_page");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (selectedImages == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tambahkan Sampul Berita'),
          ),
        );
      }
      if (judulC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tambahkan Judul Berita'),
          ),
        );
      }
      if (isiBeritaC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tambahkan Isi Berita',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          "Upload Berita",
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coverBerita(),
              judulBerita(),
              isiBerita(),
              button(),
            ],
          ),
        ),
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
            if (!isLoading) {
              upBerita();
            }
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
            isLoading ? "Loading..." : "Upload Berita",
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

  Widget isiBerita() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Isi Berita",
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          controller: isiBeritaC,
          maxLines: 5, // Set the number of lines for the text field
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaulBorderadius),
                borderSide: BorderSide.none),
            hintText: 'Jelaskan tentang latar kejadiannya',
            hintStyle: greyTertiaryTextStyle.copyWith(
              fontSize: 14,
            ),
            filled: true,
            fillColor: background1Color, // Background color for the text field
          ),
          style: blackTextStyle.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Widget judulBerita() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: defaultMargin,
        ),
        Text(
          "Judul Berita",
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 24),
          height: 48,
          child: TextField(
            controller: judulC,
            style: blackTextStyle.copyWith(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: background1Color,
              hintText: "Tambahkan Judul",
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
      ],
    );
  }

  Widget coverBerita() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: defaultMargin,
        ),
        Text(
          "Tambahkan Sampul Berita",
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
        ),
        selectedImages == null
            ? GestureDetector(
                onTap: () {
                  imageAddd();
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 112,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        defaulBorderadius,
                      ),
                      color: background1Color,
                      border: Border.all(
                        width: 1,
                        color: greyDarkColor,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/Kamera.png",
                            width: 32,
                            color: greyDarkColor,
                          ),
                          Text(
                            "Unggah foto/video",
                            style: greyTertiaryTextStyle.copyWith(
                                fontSize: 16, fontWeight: medium),
                          ),
                        ],
                      ),
                    )),
              )
            : GestureDetector(
                onTap: () {
                  imageAddd();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 176,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        defaulBorderadius,
                      ),
                      color: background1Color,
                      border: Border.all(
                        width: 1,
                        color: greyDarkColor,
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(selectedImages!.path)))),
                ),
              )
      ],
    );
  }
}
