import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../shared/theme.dart';
import '../widgets/header_baground.dart';
import '../widgets/laporan_list.dart';
import '../widgets/title_widget.dart';

class AktivitasScreen extends StatefulWidget {
  const AktivitasScreen({super.key});

  @override
  State<AktivitasScreen> createState() => _AktivitasScreenState();
}

class _AktivitasScreenState extends State<AktivitasScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderBaground(),
          kategoriLaporan(),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                SingleChildScrollView(
                  child: LaporanList(
                    title: "", //saya ingin menambahkan semuanya disini
                  ),
                ),
                SingleChildScrollView(
                  child: LaporanList(
                    title: "Laporan Terkirim",
                  ),
                ),
                SingleChildScrollView(
                  child: LaporanList(
                    title: "Laporan Diproses",
                  ),
                ),
                SingleChildScrollView(
                  child: LaporanList(
                    title: "Laporan Telah Diselidiki",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget kategoriLaporan() {
    return Container(
      padding: EdgeInsets.only(
          right: defaultMargin, left: defaultMargin, bottom: defaultMargin),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            title: "Kategori Laporan",
          ),
          SizedBox(
            height: defaultMargin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xff776CB3,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _pageController.jumpToPage(0);
                      },
                      icon: Image.asset(
                        "assets/icons/Beranda.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Semua",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xff82A3F9,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _pageController.jumpToPage(1);
                      },
                      icon: Image.asset(
                        "assets/icons/Terkirim.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Terkirim",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xffF7B57F,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _pageController.jumpToPage(2);
                      },
                      icon: Image.asset(
                        "assets/icons/Diproses.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Diproses",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(
                        0xff6FF574,
                      ),
                      borderRadius: BorderRadius.circular(defaulBorderadius),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _pageController.jumpToPage(3);
                      },
                      icon: Image.asset(
                        "assets/icons/Tuntas.png",
                        width: 32,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Tuntas",
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
