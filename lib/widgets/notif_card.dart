import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../shared/theme.dart';

class NotifCard extends StatelessWidget {
  const NotifCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(
          bottom: 12, right: defaultMargin, left: defaultMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaulBorderadius),
        color: whiteColor,
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/polis2.png",
            width: 52,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Laporan Telah Ditindaki!",
                  style:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Lihat hasil laporan anda untuk mengetahui tindak lanjut yang diberikan",
                  style: greyTertiaryTextStyle.copyWith(
                      fontSize: 12, color: Color(0xff595959)),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "1 Jam yang lalu",
                  style: greyTertiaryTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
