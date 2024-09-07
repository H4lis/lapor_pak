import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  String? id;
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  bool isPicked = false;
  TextEditingController alamatController = TextEditingController();
  TextEditingController lurahDesaController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();
  TextEditingController kabupatenController = TextEditingController();

  List<File> selectedImages = [];
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void imageAddd() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> lapor() async {
    if (_selectedCategory != null &&
        _selectedTindak != null &&
        selectedImages != null &&
        kronologisC.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        String uid = auth.currentUser!.uid;
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference<Map<String, dynamic>> collLaporan =
            await firestore.collection("laporan");

        DateTime now = DateTime.now();
        String fullDateTimeString = now.toString();
        String dateAndTime = fullDateTimeString.split('.')[0];

        List<String> imageUrls = [];
        for (File image in selectedImages) {
          String fileName =
              '${dateAndTime}_${DateTime.now().millisecondsSinceEpoch}.jpg';
          String filePath = '$dateAndTime/$fileName';
          id = dateAndTime;
          await storage.ref(filePath).putFile(image);
          String urlImage = await storage.ref(filePath).getDownloadURL();
          imageUrls.add(urlImage);
        }

        await collLaporan.doc(dateAndTime).set(
          {
            "uid": uid,
            "id": id,
            "lokasi": kronologisC.text,
            "kronologis": kronologisC.text,
            "kategoriUnggahan": _selectedCategory,
            "image": imageUrls,
            "tindakLanjut": _selectedTindak,
            "alamat": alamatController.text,
            "lurah": lurahDesaController.text,
            "kecamatan": kecamatanController.text,
            "kabupaten": kabupatenController.text,
            "status": "Laporan Terkirim",
          },
        );
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
      if (selectedImages.isEmpty) {
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
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () async {
            if (!isLoading) {
              setState(() {
                isLoading = true;
              });
              _determinePosition();
              Position position = await _determinePosition();
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  position.latitude, position.longitude);
              print(position);
              print("==================");
              print(placemarks[0]);
              print("==================");
              alamatController.text = placemarks[0].street.toString();
              lurahDesaController.text = placemarks[0].subLocality.toString();
              kecamatanController.text = placemarks[0].locality.toString();
              kabupatenController.text =
                  placemarks[0].subAdministrativeArea.toString();
              setState(() {
                isLoading = false;
              });
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12)),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: isLoading
                  ? [
                      Text(
                        "Loading...",
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      )
                    ]
                  : [
                      Icon(
                        Icons.add_location_alt_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        isLoading ? "Loading..." : "Lokasi Sekarang",
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ]),
        ),
        TitleWidget(
          title: "Alamat Lengkap",
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          height: 48,
          child: TextField(
            controller: alamatController,
            style: blackTextStyle.copyWith(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: background1Color,
              hintText: "Alamat Lengkap",
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
        TitleWidget(
          title: "Keluarahan/Desa",
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          height: 48,
          child: TextField(
            controller: lurahDesaController,
            style: blackTextStyle.copyWith(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: background1Color,
              hintText: "Keluarahan/Desa",
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
        TitleWidget(
          title: "Kecamatan",
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          height: 48,
          child: TextField(
            controller: kecamatanController,
            style: blackTextStyle.copyWith(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: background1Color,
              hintText: "Kecamatan",
              hintStyle: greyTertiaryTextStyle.copyWith(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaulBorderadius),
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
        TitleWidget(
          title: "Kabupaten/Kota",
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          height: 48,
          child: TextField(
            controller: kabupatenController,
            style: blackTextStyle.copyWith(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: background1Color,
              hintText: "Kabupaten/Kota",
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
        selectedImages.length > 0
            ? Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 12),
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffEDF2FF),
                              border: Border.all(
                                width: 1,
                                color: Color(0xffCDC9E1),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(selectedImages[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox()
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
