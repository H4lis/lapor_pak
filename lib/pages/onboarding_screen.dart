import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currenPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      currenPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: <Widget>[
                _buildPage(
                    widthScreen,
                    "onBoarding.png",
                    "LaporPak,",
                    "Ewako Lawan Narkoba!",
                    "Berantaskan Narkoba! Aplikasi ini dirancang untuk kemudahan Anda dalam melaporkan kegiatan mencurigakan terkait dengan narkoba"),
                _buildPage(
                    widthScreen,
                    "onBoarding2.png",
                    "Cepat Lapor,",
                    "Siri’kangi Narkoba!",
                    "Malukan Narkoba! Segera lapor demi kebaikan bersama! cukup dengan keterangan anda, info lokasi kejadian dan bukti foto atau video"),
                _buildPage(
                    widthScreen,
                    "onBoarding3.png",
                    "Terimakasih Pak!",
                    "",
                    "Segera lapor demi kebaikan bersama! cukup dengan keterangan anda, info lokasi kejadian dan bukti foto atau video")
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 8,
                    width: currenPage == i ? 24 : 8,
                    margin: EdgeInsets.only(
                        right: i == 1 ? 10 : 0,
                        left: i == 1 ? 10 : 0,
                        bottom: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      color: currenPage == i ? primaryColor : second6Color,
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  Widget _buildPage(
    double widthScreen,
    String imagePath,
    String title,
    String title2,
    String description,
  ) {
    return Padding(
      padding: EdgeInsets.all(defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/$imagePath",
              width: widthScreen * 0.90,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
              text: title,
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
                fontStyle: title2 == "" ? FontStyle.normal : FontStyle.italic,
              ),
            ),
            TextSpan(
              text: " ${title2}",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ])),
          SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: blackTextStyle.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          title2 == ""
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/daftar_screen');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          defaulBorderadius,
                        ),
                      ),
                      minimumSize: Size(widthScreen * 0.53, 48)),
                  child: Text(
                    "Mulai",
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
