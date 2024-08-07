import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';

import '../widgets/title_widget.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background1Color,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  title: "Pengaturan AkunNNNN",
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ubah_password_screen');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    margin: EdgeInsets.only(bottom: 24, top: 24),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/Pass.png",
                          width: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ubah Password",
                          style: blackTextStyle.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(defaulBorderadius),
                  ),
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/Tentang.png",
                        width: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Tentang Aplikasi LaporPak",
                        style: blackTextStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(defaulBorderadius),
                  ),
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/Syarat.png",
                        width: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Syarat & Ketentuan",
                        style: blackTextStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(defaulBorderadius),
                  ),
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/Privasi.png",
                        width: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Kebijakan Privasi",
                        style: blackTextStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(defaulBorderadius),
                  ),
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/Logout.png",
                        width: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Keluar",
                        style: blackTextStyle.copyWith(
                            fontSize: 14, color: Color(0xffFC2E2E)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: 40,
          bottom: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF200F84),
            Color(0xFF120A41),
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "0822 5241 4811",
                  style:
                      whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
                Text(
                  "anonimt126@gmail.com",
                  style: whiteTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/ubah_profile_screen");
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(72, 23),
              backgroundColor: primaryColor,
            ),
            child: Text(
              "Ubah",
              style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
