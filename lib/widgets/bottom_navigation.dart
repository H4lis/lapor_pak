import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<String> itemmBar = [
    'Beranda',
    'Aktivitas',
    'Lapor',
    'Notifikasi',
    'Akun',
  ];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return BottomAppBar(
      // shape: const CircularNotchedRectangle(),
      // notchMargin: 6,
      shadowColor: blackColor,
      elevation: 10,
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          itemmBar.length,
          (i) => GestureDetector(
              onTap: () {
                onTap(i);
              },
              child: i == 2
                  ? SizedBox(
                      width: 50,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/icons/${itemmBar[i]}.png",
                          width: 24,
                          color: selectedIndex == i
                              ? primaryColor
                              : greyTertiaryColor,
                        ),
                        SizedBox(
                          width: 48,
                          child: Text(
                            itemmBar[i],
                            textAlign: TextAlign.center,
                            style: greyTertiaryTextStyle.copyWith(
                              fontWeight: medium,
                              color: selectedIndex == i
                                  ? primaryColor
                                  : greyTertiaryColor,
                              fontSize: 10,
                            ),
                          ),
                        )
                      ],
                    )),
        ),
      ),
    );
  }
}
