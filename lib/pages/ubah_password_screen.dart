import 'package:flutter/material.dart';
import 'package:lapor_pak/widgets/app_bar_Widget.dart';

import '../shared/theme.dart';

class UbahPasswordScreen extends StatelessWidget {
  const UbahPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Ubah Password"),
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
                      "Password Lama",
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
                      "Password Baru",
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
