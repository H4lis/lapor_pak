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
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    TextEditingController emailC = TextEditingController();
    TextEditingController passC = TextEditingController();
    TextEditingController nomorTeleponC = TextEditingController();
    bool _isChecked = false;

    void daftar() async {
      if (emailC.text.isNotEmpty &&
          passC.text.isNotEmpty &&
          nomorTeleponC.text.isNotEmpty) {
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailC.text,
            password: passC.text,
          );

          print(userCredential);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        SnackBar(content: Text("Terjadi Kesalahan"));
      }
    }

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
                      "Password",
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                      height: 48,
                      child: TextField(
                        controller: passC,
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility_outlined,
                              color: greyTertiaryColor,
                            ),
                            onPressed: () {},
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
                                  // Tambahkan tindakan saat teks ini ditekan
                                ),
                                TextSpan(
                                  text: ' serta ',
                                  style: blackTextStyle.copyWith(fontSize: 12),
                                ),
                                TextSpan(
                                  text: 'Kebijakan Privasi',
                                  style: BlueTextStyle.copyWith(fontSize: 12),
                                  // Tambahkan tindakan saat teks ini ditekan
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
                        // Navigator.pushReplacementNamed(
                        //     context, '/verifikasi_screen')
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
