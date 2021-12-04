import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/MyColors.dart';

class MyText extends StatelessWidget {
  final String title;
  final Color color;
  final double size;
  final TextAlign alien;
  final TextDecoration decoration;
  final TextOverflow overflow;
  final bool isNumber;
  final FontWeight fontWeight;

  MyText(
      {this.title,
      this.color,
      this.size,
      this.alien,
      this.decoration,
      this.overflow,
      this.isNumber = false,
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title",
      textAlign: alien ?? TextAlign.start,
      textScaleFactor: 1.2,
//      overflow: TextOverflow.ellipsis,
      style: context.locale.languageCode == "ar"
          ? GoogleFonts.cairo(
              color: color ?? MyColors.primary,
              fontSize: size,
              decoration: decoration ?? TextDecoration.none,
              fontWeight: fontWeight)
          : GoogleFonts.roboto(
              color: color ?? MyColors.primary,
              fontSize: size,
              decoration: decoration,
              fontWeight: fontWeight),
      overflow: overflow,
    );
  }
}
