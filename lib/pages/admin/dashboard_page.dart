import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lapor_pak/shared/theme.dart';

import '../../widgets/title_widget.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void logout() async {
    await auth.signOut();
    Navigator.pushNamed(context, '/login_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
              top: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                cardRekap(),
                const TitleWidget(
                  title: "Berita dan Informasi",
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    terkirim(),
                    SizedBox(
                      width: 12,
                    ),
                    diProses()
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    diSelidiki(),
                    SizedBox(
                      width: 12,
                    ),
                    rawan()
                  ],
                ),
                SizedBox(
                  height: 98,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rawan() {
    return Flexible(
      child: Container(
        height: 150,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: Offset(0, 0),
              blurRadius: 12, // blur = 12
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/warning.png',
                  width: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Terkirim",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 8,
                          color: Color(0xffE6A600)),
                    ),
                    Text(
                      "+16%",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium, fontSize: 8, color: redyColor),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "178",
              style:
                  blackTextStyle.copyWith(fontSize: 48, fontWeight: semiBold),
            ),
            Text(
              "Daerah Rawan",
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ],
        ),
      ),
    );
  }

  Widget diSelidiki() {
    return Flexible(
      child: Container(
        height: 150,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: Offset(0, 0),
              blurRadius: 12, // blur = 12
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.check_circle,
                  weight: 24,
                  color: Color(0xff71F876),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Terkirim",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 8,
                          color: Color(0xff12F31B)),
                    ),
                    Text(
                      "+16%",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium, fontSize: 8, color: redyColor),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "24",
              style:
                  blackTextStyle.copyWith(fontSize: 48, fontWeight: semiBold),
            ),
            Text(
              "Selesai Diselidiki",
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ],
        ),
      ),
    );
  }

  Widget diProses() {
    return Flexible(
      child: Container(
        height: 150,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: Offset(0, 0),
              blurRadius: 12, // blur = 12
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.sync,
                  weight: 24,
                  color: Color(0xffF4B37C),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Terkirim",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 8,
                          color: Color(0xffF5882D)),
                    ),
                    Text(
                      "+16%",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 8,
                          color: Color(0xff0DA613)),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "111",
              style:
                  blackTextStyle.copyWith(fontSize: 48, fontWeight: semiBold),
            ),
            Text(
              "Laporan Diproses",
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ],
        ),
      ),
    );
  }

  Widget terkirim() {
    return Flexible(
      child: Container(
        height: 150,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: Offset(0, 0),
              blurRadius: 12, // blur = 12
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.outbox,
                  weight: 24,
                  color: Color(0xff84A6FB),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Terkirim",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 8,
                          color: Color(0xff326AF9)),
                    ),
                    Text(
                      "+16%",
                      style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 8,
                          color: Color(0xff0DA613)),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "5",
              style:
                  blackTextStyle.copyWith(fontSize: 48, fontWeight: semiBold),
            ),
            Text(
              "Laporan Terkirim",
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardRekap() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0xFF1736D8).withOpacity(0.24),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(
              8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: primaryColorDark,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: whiteColor,
                ),
                Text(
                  "01 Agustus 2024",
                  style: whiteTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(
                  8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryColorDark,
                ),
                child: Image.asset(
                  "assets/icons/Akun.png",
                  color: whiteColor,
                  width: 27,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "920 Org",
                      style: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: semiBold),
                    ),
                    Text(
                      "User",
                      style: whiteTextStyle.copyWith(
                          fontSize: 12, fontWeight: bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(
                  8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryColorDark,
                ),
                child: Image.asset(
                  "assets/icons/Aktivitas.png",
                  color: whiteColor,
                  width: 27,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2012 Lp",
                    style: whiteTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  Text(
                    "Laporan",
                    style:
                        whiteTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            "assets/images/admin.jpg",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 18,
        ),
        Expanded(
          child: Text(
            "Halo Admin",
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
        ),
        IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.login_outlined))
      ],
    );
  }
}
