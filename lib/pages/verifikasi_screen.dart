import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';

import '../widgets/button_navigation_widget.dart';
import '../widgets/code_textfield.dart';

class VerifikasiScreen extends StatelessWidget {
  const VerifikasiScreen({super.key});

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
              textAlign: TextAlign.center,
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
            ElevatedButton(
              onPressed: () {
                _showVerificationDialog(context);
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
                "Lanjutkan",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showVerificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaulBorderadius),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/berhasil.png',
              width: 216, // Adjust according to your image size
            ),
            SizedBox(height: 20),
            Text(
              "Verifikasi Berhasil",
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Masuk ke halaman utama untuk memulai pelaporan",
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacementNamed(context, '/main_page');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaulBorderadius),
                ),
              ),
              child: Text(
                "Lanjutkan",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
