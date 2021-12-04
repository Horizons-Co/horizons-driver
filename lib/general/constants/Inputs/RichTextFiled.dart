import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MyColors.dart';

class RichTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final EdgeInsets margin;
  final TextInputType type;
  final int min, max;
  final double height;
  final Function(String value) validate;
  final Color fillColor;
  final bool readOnly;
  final TextInputAction action;
  final Function(String value) submit;

  RichTextFiled(
      {this.label,
      this.hint,
      this.controller,
      this.margin = const EdgeInsets.all(0),
      this.type = TextInputType.text,
      this.max,
      this.min,
      this.height,
      this.validate,
      this.fillColor,
      this.readOnly = false,
      this.action,
      this.submit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      child: TextFormField(
        controller: controller,
        keyboardType: type ?? TextInputType.multiline,
        textInputAction: action ?? TextInputAction.done,
        onFieldSubmitted: submit,
        minLines: min,
        maxLines: max,
        readOnly: readOnly,
        style: context.locale.languageCode != "ar"
            ? GoogleFonts.roboto(fontSize: 18, color: Colors.black)
            : GoogleFonts.cairo(fontSize: 14, color: Colors.black),
        validator: (value) => validate(value),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.white, width: .5),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: MyColors.white, width: 1)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors.grey.withOpacity(.5), width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          errorStyle: context.locale.languageCode != "ar"
              ? GoogleFonts.roboto(fontSize: 12)
              : GoogleFonts.cairo(fontSize: 10),
          labelText: label != null ? "  $label  " : null,
          hintText: hint != null ? hint : null,
          alignLabelWithHint: true,
          labelStyle: context.locale.languageCode != "ar"
              ? GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)
              : GoogleFonts.cairo(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
          // fillColor: fillColor ?? MyColors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // filled: true
        ),
      ),
    );
  }
}
