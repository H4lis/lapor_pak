import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lapor_pak/shared/theme.dart';
import 'package:lapor_pak/widgets/title_widget.dart';

import '../widgets/button_navigation_widget.dart';

class LaporScreen extends StatefulWidget {
  const LaporScreen({super.key});

  @override
  State<LaporScreen> createState() => _LaporScreenState();
}

class _LaporScreenState extends State<LaporScreen> {
  TextEditingController kronologisC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? _selectedCategory;
  String? _selectedTindak;

  Future<void> lapor() async {
    String uid = auth.currentUser!.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collLaporan =
        await firestore.collection("users").doc(uid).collection("laporan");

    DateTime now = DateTime.now();
    String fullDateTimeString = now.toString();
    String dateAndTime = fullDateTimeString.split('.')[0];

    await collLaporan.doc(dateAndTime).set({
      "kronologis": kronologisC.text,
      "lokasi": kronologisC.text,
      "kategoriUnggahan" : _selectedCategory,
      "tindakLanjut" : _selectedCategory
    });
    print("========================");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          "Lapor",
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                info(),
                unggah(),
                kategori(),
                lokasi(),
                kronologis(),
                button()
              ],
            ),
          )),
    );
  }

  button() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            lapor()
                // Navigator.pushReplacementNamed(context, '/main_page')
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
            "Kirim Laporan",
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget kronologis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: "Deskripsi Kronologis",
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          controller: kronologisC,
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
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget lokasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: "Lokasi",
        ),
        Container(
          height: 48,
          width: double.infinity,
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: background1Color,
            borderRadius: BorderRadius.circular(
              defaulBorderadius,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Image.asset(
                "assets/icons/Lokasi.png",
                width: 24,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Tambah Lokasi",
                style: greyTertiaryTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(
          title: "Lengkapi Form Laporan",
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          "Silahkan buat laporan anda terkait orang atau wilayah yang terindifikasi narkoba",
        ),
      ],
    );
  }

  Widget unggah() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(
          title: "Unggah Foto atau Vidio",
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          height: 112,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              defaulBorderadius,
            ),
            color: bluetColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/Kamera.png",
                  width: 32,
                ),
                Text(
                  "Unggah foto/video",
                  style:
                      whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Flexible(
              flex: 1, // Atur nilai flex sesuai keinginan
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffEDF2FF),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffCDC9E1),
                    )),
                child: Center(
                  child: Image.asset(
                    'assets/icons/Image.png',
                    width: 24,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffEDF2FF),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffCDC9E1),
                    )),
                child: Center(
                  child: Image.asset(
                    'assets/icons/Image.png',
                    width: 24,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffEDF2FF),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffCDC9E1),
                    )),
                child: Center(
                  child: Image.asset(
                    'assets/icons/Image.png',
                    width: 24,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget kategori() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: "Kategori Unggahan",
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              color: background1Color,
              borderRadius: BorderRadius.circular(defaulBorderadius)),
          child: RadioListTile<String>(
            title: Text(
              'Lapangan Kejadian',
              style: blackTextStyle.copyWith(fontSize: 14),
            ),
            value: 'Penyelidikan',
            groupValue: _selectedCategory,
            onChanged: (String? value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              color: background1Color,
              borderRadius: BorderRadius.circular(defaulBorderadius)),
          child: RadioListTile<String>(
            title: Text(
              'Media Sosial',
              style: blackTextStyle.copyWith(fontSize: 14),
            ),
            value: 'Media Sosial',
            groupValue: _selectedCategory,
            onChanged: (String? value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
        ),
        TitleWidget(
          title: "Tindak Lanjut",
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              color: background1Color,
              borderRadius: BorderRadius.circular(defaulBorderadius)),
          child: RadioListTile<String>(
            title: Text(
              'Penyelidikan',
              style: blackTextStyle.copyWith(fontSize: 14),
            ),
            value: 'Penyelidikan',
            groupValue: _selectedTindak,
            onChanged: (String? value) {
              setState(() {
                _selectedTindak = value;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              color: background1Color,
              borderRadius: BorderRadius.circular(defaulBorderadius)),
          child: RadioListTile<String>(
            title: Text(
              'Rehabilitasi',
              style: blackTextStyle.copyWith(fontSize: 14),
            ),
            value: 'Media Sosial',
            groupValue: _selectedTindak,
            onChanged: (String? value) {
              setState(() {
                _selectedTindak = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
