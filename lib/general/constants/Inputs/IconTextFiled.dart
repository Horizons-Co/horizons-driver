import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MyColors.dart';

class IconTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final EdgeInsets margin;
  final TextInputType type;
  final Widget suffixIcon;
  final bool isPassword;
  final Widget prefixIcon;
  final Function(String value) validate;
  final Color filledColor;
  final TextInputAction action;
  final Function(String value) submit;
  final Function(String) onChange;

  IconTextFiled(
      {this.label,
      this.controller,
      this.margin,
      this.type,
      this.action,
      this.submit,
      this.suffixIcon,
      this.isPassword = false,
      this.prefixIcon,
      this.filledColor,
      this.validate,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 50,
              maxHeight: 70,
              minWidth: double.infinity,
              maxWidth: double.infinity),
          child: TextFormField(
            controller: controller,
            keyboardType: type ?? TextInputType.text,
            enabled: true,
            obscureText: isPassword,
            textInputAction: action ?? TextInputAction.done,
            onFieldSubmitted: submit,
            onChanged: onChange,
            style: context.locale.languageCode != "ar"
                ? GoogleFonts.roboto(fontSize: 20, color: Colors.black)
                : GoogleFonts.cairo(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
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
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 2)),
              errorStyle: context.locale.languageCode != "ar"
                  ? GoogleFonts.roboto(fontSize: 12)
                  : GoogleFonts.cairo(fontSize: 10),
              labelText: "$label",
              labelStyle: context.locale.languageCode != "ar"
                  ? GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)
                  : GoogleFonts.cairo(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              // filled: true,
              // fillColor: filledColor ?? MyColors.white),
            ),
          )),
    );
  }
}
