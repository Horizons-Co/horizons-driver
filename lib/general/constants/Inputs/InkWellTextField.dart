import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MyColors.dart';

class InkWellTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final EdgeInsets margin;
  final TextInputType type;
  final Widget icon;
  final Function onTab;
  final Widget prefix;
  final Color borderColor;
  final Function(String value) validate;

  InkWellTextField(
      {this.label,
      this.controller,
      this.margin,
      this.type,
      this.onTab,
      this.icon,
      this.prefix,
      this.borderColor,
      this.validate});

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
        child: InkWell(
          onTap: onTab,
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              keyboardType: type ?? TextInputType.text,
              enabled: true,
              validator: (value) => validate(value),
              style: context.locale.languageCode != "ar"
                  ? GoogleFonts.roboto(fontSize: 18, color: Colors.black)
                  : GoogleFonts.cairo(fontSize: 14, color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColors.white, width: .5),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: MyColors.white, width: 1)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyColors.white.withOpacity(.5), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                suffixIcon: icon,
                prefixIcon: prefix,
                errorStyle: context.locale.languageCode != "ar"
                    ? GoogleFonts.roboto(fontSize: 12)
                    : GoogleFonts.cairo(fontSize: 10),
                labelText: "  $label  ",
                labelStyle: context.locale.languageCode != "ar"
                    ? GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)
                    : GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                // filled: true,
                // fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
