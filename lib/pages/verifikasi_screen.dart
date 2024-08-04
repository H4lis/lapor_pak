import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';

import '../widgets/button_navigation_widget.dart';
import '../widgets/code_textfield.dart';

class VerifikasiPage extends StatelessWidget {
  const VerifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          "Verifikasi",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 45),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text:
                    'Masukkan kode verifikasi yang telah dikirimkan ke nomor HP Anda ',
                style: blackTextStyle.copyWith(fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                    text: '+62 *********12',
                    style: BlueTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CodeTextField(),
                CodeTextField(),
                CodeTextField(),
                CodeTextField(),
              ],
            ),
            SizedBox(
              height: 36,
            ),
            Text(
              "Belum menerima kode?",
              style: blackTextStyle.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 12,
            ),
            RichText(
              text: TextSpan(
                text: 'Kirim ulang dalam  ',
                style: blackTextStyle.copyWith(fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                    text: '00.27',
                    style: BlueTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 68,
            ),
            ButtonNavigationWidget()
          ],
        ),
      ),
    );
  }
}
