import 'package:flutter/material.dart';

import '../shared/theme.dart';

class UbahProfileScreen extends StatelessWidget {
  const UbahProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Ubah Profile",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Lengkap",
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 24),
                      height: 48,
                      child: TextField(
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteColor,
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
                        ),
                      ),
                    ),
                    Text(
                      "Nomor Telepon",
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 24),
                      height: 48,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteColor,
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
                        ),
                      ),
                    ),
                    Text(
                      "Email",
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 24),
                      height: 48,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteColor,
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/main_page');
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
                "Masuk",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
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
