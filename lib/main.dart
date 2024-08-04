import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lapor_pak/pages/daftar_screen.dart';
import 'package:lapor_pak/pages/lapor_screen.dart';
import 'package:lapor_pak/pages/main_page.dart';
import 'package:lapor_pak/pages/verifikasi_screen.dart';
import 'firebase_options.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LoginScreen(),
        // SplashScreen(),
        '/main_page': (context) => MainPage(),
        '/lapor_screen': (context) => LaporScreen(),
        '/daftar_screen': (context) => DaftarScreen(),
      },
    );
  }
}
