import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';

class BottomNavigationAdmin extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  BottomNavigationAdmin({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<String> itemmBar = [
    'Dashboard',
    'Upload Berita',
    'Update Laporan',
  ];
  final List<String> itemmIcon = [
    'Dashboard',
    'Upload',
    'Akun',
  ];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return BottomAppBar(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/${itemmIcon[i]}.png",
                    width: 24,
                    color:
                        selectedIndex == i ? primaryColor : greyTertiaryColor,
                  ),
                  SizedBox(
                    width: 76,
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
