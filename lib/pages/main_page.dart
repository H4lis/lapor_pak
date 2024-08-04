import 'package:flutter/material.dart';
import 'package:lapor_pak/pages/aktivitas_screen.dart';
import 'package:lapor_pak/pages/akun_screen.dart';
import 'package:lapor_pak/pages/beranda_screen.dart';
import 'package:lapor_pak/pages/lapor_screen.dart';
import 'package:lapor_pak/pages/notifikasi_screen.dart';
import 'package:lapor_pak/shared/theme.dart';
import 'package:lapor_pak/widgets/bottom_navigation.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectetedIndex = 0;
  final List<Widget> screens = [
    const BerandaScreen(),
    const AktivitasScreen(),
    const LaporScreen(),
    const NotifikasiScreen(),
    const AkunScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: screens[selectetedIndex],
      floatingActionButton: Floating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: BottomNavigation(
        selectedIndex: selectetedIndex,
        onTap: (val) {
          setState(() {
            selectetedIndex = val;
          });
        },
      ),
    );
  }

  Widget Floating() {
    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        elevation: 10,
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/lapor_screen');
        },
        child: Image.asset(
          "assets/icons/Lapor.png",
          width: 34,
        ),
      ),
    );
  }
}
