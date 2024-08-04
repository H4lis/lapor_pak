import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';
import 'package:lapor_pak/widgets/laporan_card.dart';
import 'package:lapor_pak/widgets/title_widget.dart';

import '../widgets/berita_card.dart';
import '../widgets/laporan_list.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context),
            beritaProduct(),
            LaporanList(
              title: "Pernyataan Laporan",
            ),
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      height: 268,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF200F84), Color(0xFF120A41)],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang!",
                        style: whiteTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 20),
                      ),
                      Text(
                        "Nurul Afria",
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    "assets/images/profile.jpeg",
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/polis.png",
                        height: 64,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          "Laporkan orang atau wilayah yang terindikasi narkoba . . . ",
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
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
                        minimumSize: Size(double.infinity, 32)),
                    child: Text(
                      "Laporkan sekarang",
                      style: whiteTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget beritaProduct() {
    return Container(
      color: background1Color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: defaultMargin),
              child: TitleWidget(
                title: "Berita dan Informasi",
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: defaultMargin,
                ),
                BeritaCard(),
                BeritaCard(),
                BeritaCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
