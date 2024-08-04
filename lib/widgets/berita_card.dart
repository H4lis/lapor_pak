import 'package:flutter/material.dart';

import '../shared/theme.dart';

class BeritaCard extends StatelessWidget {
  const BeritaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 149,
      margin: EdgeInsets.only(right: 8, top: 16, bottom: defaultMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.12), // Warna bayangan dengan 12% opacity
            offset: Offset(0, 2), // Posisi bayangan (x: 0, y: 2)
            blurRadius: 4, // Jarak blur
            spreadRadius: 0, // Penyebaran bayangan
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            child: Image.asset(
              height: 80,
              width: 136,
              "assets/images/berita.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Id in quis.dolor sit  in quis.dolor sit  in quis.dolor sit",
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style: blackTextStyle.copyWith(fontSize: 10),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Lorem ipsum dolor sit amet ",
                  overflow: TextOverflow.ellipsis,
                  style: greyTextDisableTextStyle.copyWith(fontSize: 8),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
