import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared/theme.dart';

class ButtonNavigationWidget extends StatelessWidget {
  const ButtonNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/main_page');
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaulBorderadius,
            ),
          ),
          minimumSize: Size(double.infinity, 48)),
      child: Text(
        "Kirim Laporan",
        style: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: semiBold,
        ),
      ),
    );
  }
}
