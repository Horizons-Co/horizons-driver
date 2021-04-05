import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MyColors.dart';

class LabelTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final EdgeInsets margin;
  final bool isPassword;
  final TextInputType type;
  final Function(String value) validate;
  final Function() onSubmit;
  final Function(String) onChange;
  final TextInputAction action;
  final int maxLength;

  LabelTextField(
      {this.label,
      this.maxLength,
      this.controller,
      this.onChange,
      this.margin,
      this.isPassword = false,
      this.action,
      this.onSubmit,
      this.type = TextInputType.text,
      this.validate});

  @override
  _LabelTextFieldState createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.all(0),
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
          maxLength: widget.maxLength,
          controller: widget.controller,
          keyboardType: widget.type ?? TextInputType.text,
          obscureText: widget.isPassword,
          onEditingComplete: widget.onSubmit,
          onChanged: widget.onChange,
          enableSuggestions: false,
          autocorrect: false,
          textInputAction: widget.action ?? TextInputAction.next,
          style: context.locale.languageCode != "ar"
              ? GoogleFonts.roboto(fontSize: 18, color: Colors.black)
              : GoogleFonts.cairo(fontSize: 14, color: Colors.black),
          validator: (value) => widget.validate(value),
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
                    BorderSide(color: MyColors.white.withOpacity(.5), width: 1),
                borderRadius: BorderRadius.circular(8)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.white, width: 2)),
            errorStyle: context.locale.languageCode != "ar"
                ? GoogleFonts.roboto(fontSize: 12)
                : GoogleFonts.cairo(fontSize: 10),
            labelText: "  ${widget.label}  ",
            labelStyle: context.locale.languageCode != "ar"
                ? GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)
                : GoogleFonts.cairo(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            // filled: true,
            // fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
