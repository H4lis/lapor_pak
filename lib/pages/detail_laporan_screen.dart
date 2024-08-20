// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lapor_pak/widgets/title_widget.dart';

import '../shared/theme.dart';

class DetailLaporanScreen extends StatelessWidget {
  Map<String, dynamic> data;
  DetailLaporanScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Lapor",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(title: "Laporan dari Media Sosial"),
              SizedBox(height: 12),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: data['image'] == ""
                      ? Image.asset(
                          fit: BoxFit.cover,
                          height: 176,
                          width: double.infinity,
                          "assets/images/lapor.png",
                        )
                      : Image.network(
                          data['image'],
                          fit: BoxFit.cover,
                          height: 176,
                          width: double.infinity,
                        )),
              TitleWidget(title: "Lokasi Somba Opu, Gowa"),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                height: 164,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaulBorderadius),
                  color: greyTertiaryColor,
                ),
              ),
              Text(
                "QFXQ+QFH, Jl. Tun Abdul Razak, Romangpolong, Kec. Somba Opu, Kabupaten Gowa, Sulawesi Selatan",
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    "Tindak Lanjut",
                    style: blackTextStyle.copyWith(
                        fontWeight: medium, fontSize: 16),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    data['tindakLanjut'],
                    style: blackTextStyle.copyWith(
                        fontWeight: medium, fontSize: 16, color: primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Kronologis",
                style:
                    blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                data['kronologis'] ?? 'Kronologis Tidak Diketahui',
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
