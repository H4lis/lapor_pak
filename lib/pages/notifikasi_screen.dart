import 'package:flutter/material.dart';

import '../shared/theme.dart';
import '../widgets/header_baground.dart';
import '../widgets/notif_card.dart';
import '../widgets/title_widget.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background1Color,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderBaground(),
          Container(
            margin: EdgeInsets.only(left: defaultMargin, bottom: defaultMargin),
            child: TitleWidget(
              title: "Notifikasi",
            ),
          ),
          NotifCard(),
          NotifCard(),
          NotifCard(),
        ],
      ),
    );
  }
}
