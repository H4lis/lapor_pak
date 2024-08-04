import 'package:flutter/material.dart';

import '../shared/theme.dart';
import '../widgets/button_navigation_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
            Text(
              "Password",
              style: blackTextStyle.copyWith(fontSize: 14),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 12),
              height: 48,
              child: TextField(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Lupa Password?",
                  style: BlueTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            ButtonNavigationWidget(),
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
          ],
        ),
      ),
    );
  }
}
