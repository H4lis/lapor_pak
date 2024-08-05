import 'package:flutter/material.dart';
import 'package:lapor_pak/widgets/title_widget.dart';

import '../shared/theme.dart';

class DetailLaporanScreen extends StatelessWidget {
  const DetailLaporanScreen({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(title: "Laporan dari Media Sosial"),
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  fit: BoxFit.cover,
                  height: 176,
                  width: double.infinity,
                  "assets/images/berita.png",
                ),
              ),
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
                    "Rehabilitasi",
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
                "Pada tanggal 10 Juli 2024, saya mulai mencurigai Siti, Rohida, dan Ani setelah menerima laporan guru tentang perubahan perilakunya. Selama dua minggu, kami mengamati penurunan prestasi mereka, absensi mereka tidak ada alasan yang jelas, dan perilaku mereka menjadi tidak baik seperti senang berkeliaran kemana-mana dan pulang tengah malam dalam keadaan setengah sadar. Rupanya ketika saya menggeladah pakaiannya, saya mendapati ada semacam serbuk putih yang di wadahi kantong plastik, saya curiga ini adalah narkoba.",
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
