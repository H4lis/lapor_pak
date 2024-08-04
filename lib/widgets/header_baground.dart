import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class HeaderBaground extends StatelessWidget {
  const HeaderBaground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF200F84), Color(0xFF120A41)],
          stops: [0.0, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}