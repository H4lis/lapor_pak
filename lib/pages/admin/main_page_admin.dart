import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lapor_pak/pages/admin/dashboard_page.dart';
import 'package:lapor_pak/pages/admin/update_laporan_page.dart';
import 'package:lapor_pak/pages/admin/berita_page.dart';

import '../../shared/theme.dart';
import '../../widgets/bottom_navigation_admin.dart';

class MainPageAdmin extends StatefulWidget {
  const MainPageAdmin({super.key});

  @override
  State<MainPageAdmin> createState() => _MainPageAdminState();
}

int selectedIndex = 0;
List screens = [DashboardPage(), BeritaPage(), UpdateLaporanPage()];

class _MainPageAdminState extends State<MainPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomSheet: BottomNavigationAdmin(
        selectedIndex: selectedIndex,
        onTap: (i) {
          setState(() {
            selectedIndex = i;
          });
        },
      ),
    );
  }
}
