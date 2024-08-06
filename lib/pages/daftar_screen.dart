import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_pak/widgets/app_bar_Widget.dart';

import '../shared/theme.dart';
import '../widgets/button_navigation_widget.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({super.key});

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController nomorTeleponC = TextEditingController();
  bool _isChecked = false;
  bool _obscurePassword = true;

  void daftar() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        nomorTeleponC.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await firestore.collection('users').doc(uid).set({
            'name': nameC.text,
            'email': emailC.text,
            'nomor': nomorTeleponC.text,
            'createdAt': DateTime.now().toIso8601String(),
          });
          userCredential.user!.sendEmailVerification();
        }
        _showVerificationDialog(context);
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'user-not-found') {
          errorMessage =
              'Tidak ada pengguna yang ditemukan untuk email tersebut.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Email anda tidak sesuai.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Password yang Anda masukkan salah.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Password yang diberikan terlalu lemah.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Akun dengan email tersebut sudah ada.';
        } else {
          errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    } else {
      if (nameC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nama harus diisi.'),
          ),
        );
      }
      if (emailC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email harus diisi.'),
          ),
        );
      }
      if (passC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password harus diisi.'),
          ),
        );
      }
      if (nomorTeleponC.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nomor telepon harus diisi.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Daftar"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Nama Lengkap",
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 24),
                      height: 48,
                      child: TextField(
                        controller: nameC,
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: background1Color,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Icon(
                                Icons.person_2_rounded,
                                size: 24,
                                color: greyTertiaryColor,
                              )),
                          hintText: "Masukkan Nama Lengkap",
                          hintStyle:
                              greyTertiaryTextStyle.copyWith(fontSize: 14),
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
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 24),
                      height: 48,
                      child: TextField(
                        controller: emailC,
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: background1Color,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Icon(
                                Icons.email,
                                size: 24,
                                color: greyTertiaryColor,
                              )),
                          hintText: "Masukkan Email",
                          hintStyle:
                              greyTertiaryTextStyle.copyWith(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Password",
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                      height: 48,
                      child: TextField(
                        controller: passC,
                        obscureText: _obscurePassword,
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: background1Color,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Icon(
                                Icons.lock,
                                size: 24,
                                color: greyTertiaryColor,
                              )),
                          hintText: "Masukkan Password",
                          hintStyle:
                              greyTertiaryTextStyle.copyWith(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: greyTertiaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Nomor Telepon",
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                      height: 48,
                      child: TextField(
                        controller: nomorTeleponC,
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: background1Color,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Icon(
                                Icons.phone,
                                size: 24,
                                color: greyTertiaryColor,
                              )),
                          hintText: "Masukkan Nomor Telepon",
                          hintStyle:
                              greyTertiaryTextStyle.copyWith(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaulBorderadius),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: "Dengan mendaftar, Saya menyetujui ",
                              style: blackTextStyle.copyWith(fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Syarat dan Ketentuan',
                                  style: BlueTextStyle.copyWith(fontSize: 12),
                                ),
                                TextSpan(
                                  text: ' serta ',
                                  style: blackTextStyle.copyWith(fontSize: 12),
                                ),
                                TextSpan(
                                  text: 'Kebijakan Privasi',
                                  style: BlueTextStyle.copyWith(fontSize: 12),
                                ),
                                TextSpan(
                                  text: ' yang Berlaku',
                                  style: blackTextStyle.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        daftar();
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
                        "Daftar",
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/main_page');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF1F1F1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              defaulBorderadius,
                            ),
                          ),
                          minimumSize: Size(double.infinity, 48),
                          elevation: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/Google.png',
                            width: 24,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Daftar dengan google",
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah punya akun? ",
                  style: blackTextStyle.copyWith(fontSize: 12),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/login_screen");
                  },
                  child: Text(
                    'Masuk',
                    style: BlueTextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}

void _showVerificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaulBorderadius),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/berhasil.png',
              width: 216, // Adjust according to your image size
            ),
            SizedBox(height: 20),
            Text(
              "Verifikasi Berhasil",
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Masuk ke halaman utama untuk memulai pelaporan",
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacementNamed(context, '/main_page');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaulBorderadius),
                ),
              ),
              child: Text(
                "Lanjutkan",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
