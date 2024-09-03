// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lapor_pak/widgets/app_bar_Widget.dart';

import '../shared/theme.dart';

class DetailBeritaScren extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailBeritaScren({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailBeritaScren> createState() => _DetailBeritaScrenState();
}

class _DetailBeritaScrenState extends State<DetailBeritaScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        title: Text(
          "Berita",
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                widget.data['judulBerita'],
                style:
                    blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              ),
              SizedBox(height: 12),
              Text(
                widget.data['createdAt'],
                style: greyTertiaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: 176,
                  width: double.infinity,
                  widget.data['image'],
                ),
              ),
              SizedBox(height: 12),
              Text(
                widget.data['isiBerita'],
                style: secondaryTextStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
