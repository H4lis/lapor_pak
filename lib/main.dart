import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lapor_pak/pages/admin/berita_page.dart';
import 'package:lapor_pak/pages/admin/upload_berita_screen.dart';
import 'package:lapor_pak/pages/daftar_screen.dart';
import 'package:lapor_pak/pages/detail_berita_screen.dart';
import 'package:lapor_pak/pages/detail_laporan_screen.dart';
import 'package:lapor_pak/pages/forgot_password.dart';
import 'package:lapor_pak/pages/lapor_screen.dart';
import 'package:lapor_pak/pages/main_page.dart';
import 'package:lapor_pak/pages/ubah_password_screen.dart';
import 'package:lapor_pak/pages/ubah_profile_screen.dart';
import 'package:lapor_pak/pages/verifikasi_screen.dart';
import 'firebase_options.dart';
import 'pages/admin/main_page_admin.dart';
import 'pages/login_screen.dart';
import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }
          if (snapshot.hasData
          ) {
            String userEmail = snapshot.data!.email ?? '';
            List<String> adminEmails = ["nurhalis092@gmail.com"];

            bool isAdmin = adminEmails.contains(userEmail);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: isAdmin ? MainPageAdmin() : MainPage(),
              routes: {
                '/main_page': (context) => MainPage(),
                '/main_page_admin': (context) => MainPageAdmin(),
                '/lapor_screen': (context) => LaporScreen(),
                '/daftar_screen': (context) => DaftarScreen(),
                '/login_screen': (context) => LoginScreen(),
                '/verifikasi_screen': (context) => VerifikasiScreen(),
                '/forgot_password_screen': (context) => ForgotPasssword(),
                '/ubah_profile_screen': (context) => UbahProfileScreen(),
                '/ubah_password_screen': (context) => UbahPasswordScreen(),
                '/upload_berita_screen': (context) => UploadBeritaScreen(),
              },
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: SplashScreen(),
              routes: {
                '/main_page': (context) => MainPage(),
                     '/main_page_admin': (context) => MainPageAdmin(),
                '/lapor_screen': (context) => LaporScreen(),
                '/daftar_screen': (context) => DaftarScreen(),
                '/login_screen': (context) => LoginScreen(),
                '/verifikasi_screen': (context) => VerifikasiScreen(),
                '/forgot_password_screen': (context) => ForgotPasssword(),
                '/ubah_profile_screen': (context) => UbahProfileScreen(),
                '/ubah_password_screen': (context) => UbahPasswordScreen(),
                '/upload_berita_screen': (context) => UploadBeritaScreen(),
              },
            );
          }
        });
  }
}
