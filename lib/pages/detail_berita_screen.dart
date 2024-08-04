import 'package:flutter/material.dart';
import 'package:lapor_pak/widgets/app_bar_Widget.dart';

import '../shared/theme.dart';

class DetailBeritaScren extends StatelessWidget {
  const DetailBeritaScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Berita",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Jual Sabu Demi Main Judol, 2 Sopir Sayuran Diringkus Polisi di Cianjur",
                style:
                    blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              ),
              SizedBox(height: 12),
              Text(
                "27 Juli 2024 || 13 : 14 WIB",
                style: greyTertiaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
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
              SizedBox(height: 12),
              Text(
                "Cianjur - DR (26) dan Er (26), sopir ekspedisi sayuran di Cianjur, Jawa Barat diringkus polisi usai edarkan narkoba jens sabu. Terungkap jika keduanya menggunakan uang hasil mengedarkan sabu untuk bermain judi online (Judol). Kasat Narkoba Polres Cianjur AKP Septian Pratama menyatakan, pengungkapan tersebut berawal dari informasi adanya peredaran narkoba di kawasan Puncak, Cipanas, Cianjur. Setelah dilakukan penyelidikan, diketahui ada dua orang yang mengedarkan sabu dengan sistem tempel. \n \"Setelah teridentifikasi, kami amankan dua orang pengedar yakni DR dan Er di rumah kontrakannya tadi malam,\" ujar dia, Sabtu (27/7/2024). \n\n Menurutnya setelah digeledah, petugas menemukan barang bukti berupa satu paket besar sabu seberat 51 gram. \"Keterangan dari keduanya paket tersebut baru datang, dan nantinya akan dibagi dalam paket-paket kecil siap edar,\" ujar dia.\n\nSeptian mengungkapkan, dari hasil pemeriksaan, pelaku mendapatkan untung sebesar Rp 500 ribu per orang dari setiap paket sabu yang diedarkan. Uang itu digunakan pelaku untuk bermain judi online.\n\n\"Dari 50 gram sabu itu mereka dapat untung Rp 500 ribu per orangnya. Uangnya digunakan untuk kebutuhan dan judi online,\" ucap dia. \n\nDia menuturkan pihaknya masih terus mengembangkan kasus tersebut, sebab diduga ada otak dari kelompok pelaku tersebut. \"Kita masih lakukan penyelidiikan untuk menangkap otak dan bandar besarnya,\" ungkapnya.\n\nAtas perbuatannya kedua pelaku dijerat dengan Pasal 132 juncto Pasal 114 dan 112 Undang-undang Ri nmor 35 tahun 2009 tentang Narkotika.\n\n\"Pelaku terancam kurungan penjara maksimal selama 20 tahun,\" ucapnya.\n\nDi sisi lain, DR, pelaku, mengaku jika sudah empat kali mengedarkan narkoba jenis sabu dengan sistem tempel. Menurutnya uang tersebut memang digunakan untuk bermain judi online dengan harapan uang tersebut bisa berlipat ganda.\n\n\"Banyaknya dipakai main judi online. Supaya uangnya bisa berlipat ganda dari judi. Tapi selama bermain judi bukannya menang tapi kalah terus, makanya uang dari edarkan sabu habis,\" kata dia.",
                style: secondaryTextStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
