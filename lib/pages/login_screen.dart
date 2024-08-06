import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_pak/widgets/app_bar_Widget.dart';

import '../shared/theme.dart';
import '../widgets/button_navigation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  bool _obscurePassword = true;
  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        showVerificationDialog(context);
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'user-not-found') {
          errorMessage =
              'Tidak ada pengguna yang ditemukan untuk email tersebut.';
        } else if (e.code == 'wrong-password' ||
            e.code == 'invalid-credential') {
          errorMessage = 'Password yang Anda masukkan salah.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Email yang Anda masukkan salah.';
        } else {
          errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    } else if (emailC.text.isEmpty && passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Email dan password harus diisi.'),
        ),
      );
    } else if (passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password harus diisi.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email harus diisi.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Login"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Email",
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 24),
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
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      height: 48,
                      child: TextField(
                        obscureText: _obscurePassword,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/forgot_password_screen");
                          },
                          child: Text(
                            "Lupa Password?",
                            style: BlueTextStyle.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              defaulBorderadius,
                            ),
                          ),
                          minimumSize: const Size(double.infinity, 48)),
                      child: Text(
                        "Masuk",
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/main_page');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF1F1F1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              defaulBorderadius,
                            ),
                          ),
                          minimumSize: const Size(double.infinity, 48),
                          elevation: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/Google.png',
                            width: 24,
                          ),
                          const SizedBox(
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
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun?  ",
                  style: blackTextStyle.copyWith(fontSize: 12),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/daftar_screen");
                  },
                  child: Text(
                    'Daftar',
                    style: BlueTextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}

void showVerificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/main_page');
      });
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
            const SizedBox(height: 20),
            Text(
              "Login Berhasil",
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
