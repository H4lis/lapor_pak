import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapor_pak/shared/theme.dart';
import 'package:lapor_pak/widgets/title_widget.dart';

class LaporScreen extends StatefulWidget {
  const LaporScreen({super.key});

  @override
  State<LaporScreen> createState() => _LaporScreenState();
}

class _LaporScreenState extends State<LaporScreen> {
  TextEditingController kronologisC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  String? _selectedCategory;
  String? _selectedTindak;
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  bool isPicked = false;
  XFile? pickedImage;

  void imageAddd() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = XFile(image.path);
      setState(() {
        isPicked = true;
      });
    }

    print("==================");
    if (image != null) {
      print(image.name);
    }
    print(image);
    print("==================");
  }

  Future<void> lapor() async {
    if (_selectedCategory != null &&
        _selectedTindak != null &&
        pickedImage != null &&
        kronologisC.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        String uid = auth.currentUser!.uid;
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference<Map<String, dynamic>> collLaporan =
            await firestore.collection("users").doc(uid).collection("laporan");

        DateTime now = DateTime.now();
        String fullDateTimeString = now.toString();
        String dateAndTime = fullDateTimeString.split('.')[0];

        File file = File(pickedImage!.path);
        String ext = pickedImage!.name.split('.').last;
        await storage.ref("$dateAndTime/bukti.$ext").putFile(file);
        String urlImage =
            await storage.ref("$dateAndTime/bukti.$ext").getDownloadURL();

        await collLaporan.doc(dateAndTime).set({
          "lokasi": kronologisC.text,
          "kronologis": kronologisC.text,
          "kategoriUnggahan": _selectedCategory,
          "image": urlImage,
          "tindakLanjut": _selectedTindak
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
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih Kategori Unggahan'),
          ),
        );
      }
      if (pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih Kategori Unggahan'),
          ),
        );
      }
      if (_selectedTindak == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Pilih Tindak Lanjut',
            ),
          ),
        );
      }
      if (kronologisC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Deskripsi Kronologis Harus diisi',
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
          onPressed: () async {
            if (!isLoading) {
              lapor();
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
            isLoading ? "Loading..." : "Kirim Laporan",
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
        GestureDetector(
          onTap: () {
            print("===== masuk =================");
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
                    style: whiteTextStyle.copyWith(
                        fontSize: 16, fontWeight: medium),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
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
                    ),
                    image: isPicked
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(pickedImage!.path),
                            ),
                          )
                        : null),
                child: isPicked
                    ? null
                    : Center(
                        child: Image.asset(
                          "assets/icons/Image.png",
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
            value: 'Lapangan Kejadian',
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
            value: 'Rehabilitasi',
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
