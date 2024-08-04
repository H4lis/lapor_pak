import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:lapor_pak/widgets/laporan_card.dart';

import '../shared/theme.dart';
import 'title_widget.dart';

class LaporanList extends StatelessWidget {
  final String title;
  const LaporanList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 110),
      color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, bottom: 16),
            child: TitleWidget(
              title: title,
            ),
          ),
          LaporanCard(),
          LaporanCard(),
          LaporanCard(),
        ],
      ),
    );
    ;
  }
}
