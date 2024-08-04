import 'package:flutter/material.dart';
import 'package:lapor_pak/shared/theme.dart';
import 'package:lapor_pak/widgets/app_bar_Widget.dart';

class ForgotPasssword extends StatelessWidget {
  const ForgotPasssword({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScareen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(title: 'Lupa Password'),
      body: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/forgot_pass.png",
                      width: MediaQuery.of(context).size.width,
                    ),
                    Text(
                      "Silahkan masukkan alamat email anda untuk permintaan reset password",
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Email",
                      style: blackTextStyle.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 24),
                      height: 48,
                      child: TextField(
                        style: blackTextStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: background1Color,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Icon(
                                Icons.email,
                                size: 24,
                                color: greyTertiaryColor,
                              )),
                          hintText: "Masukkan Email",
                          hintStyle:
                              greyTertiaryTextStyle.copyWith(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                defaulBorderadius), // Ganti dengan defaulBorderadius Anda
                            borderSide:
                                BorderSide.none, // Hilangkan border garis
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                defaulBorderadius), // Sama dengan defaulBorderadius Anda
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                defaulBorderadius), // Sama dengan defaulBorderadius Anda
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
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
                "Masuk",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
