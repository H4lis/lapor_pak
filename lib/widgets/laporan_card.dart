import 'package:flutter/material.dart';

import '../shared/theme.dart';

class LaporanCard extends StatelessWidget {
  const LaporanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 109,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(defaulBorderadius),
          border: Border.all(width: 1, color: neutralGray3Color)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              width: 136,
              fit: BoxFit.cover,
              "assets/images/berita.png",
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: blueLightColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    "Laporan Terkirim",
                    style: BlueTextStyle.copyWith(fontSize: 8),
                  ),
                ),
                Text(
                  "Pada tanggal 10 Juli 2024, saya mulai mencurigai Siti, Rohida, dan Ani Ani Ani Ani ,",
                  style: blackTextStyle.copyWith(fontSize: 12),
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                ),
                Text(
                  "Somba Opu, Gowa",
                  style: greyTertiaryTextStyle.copyWith(fontSize: 8),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
