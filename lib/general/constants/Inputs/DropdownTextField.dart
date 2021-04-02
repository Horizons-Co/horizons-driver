import 'package:base_structure/general/widgets/MyText.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../MyColors.dart';
import 'custom_dropDown/CustomDropDown.dart';

class DropdownTextField<DataType> extends StatefulWidget {
  final List<DataType> data;
  final GlobalKey dropKey;
  final String label;
  final DataType selectedItem;
  final bool showSelectedItem;
  final EdgeInsets margin;
  final double fontSize;
  final double labelSize;
  final dynamic validate;
  final dynamic onChange;
  final Function(String value) finData;
  final EdgeInsets downIconPadding;
  final bool useName;

  DropdownTextField(
      {this.label,
      this.margin,
      this.validate,
      this.downIconPadding,
      this.useName = true,
      this.onChange,
      this.fontSize,
      this.labelSize,
      this.finData,
      this.dropKey,
      this.data,
      this.selectedItem,
      this.showSelectedItem = false});

  @override
  DropdownTextFieldState<DataType> createState() =>
      DropdownTextFieldState<DataType>();
}

class DropdownTextFieldState<DataType> extends State<DropdownTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.white, borderRadius: BorderRadius.circular(5)),
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 5),
      child: CustomDropDown<DataType>(
        key: widget.dropKey,
        mode: Mode.BOTTOM_SHEET,
        isFilteredOnline: true,
        iconPadding: widget.downIconPadding,
        maxHeight: 300,
        label: widget.label,
        items: widget.data,
        onFind: widget.finData,
        validator: widget.validate,
        onChanged: widget.onChange,
        showSearchBox: true,
        showClearButton: true,
        selectedItem: widget.selectedItem,
        itemAsString: (dynamic u) => widget.useName ? u.name : u,
        showSelectedItem: widget.showSelectedItem,
        searchBoxDecoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors.grey.withOpacity(.5), width: 1),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          labelText: tr("search"),
        ),
        popupTitle: Container(
          height: 45,
          decoration: BoxDecoration(
            color: MyColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: MyText(
              title: widget.label,
              size: 15,
              color: MyColors.white,
            ),
          ),
        ),
        popupShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors.grey.withOpacity(.2), width: .2),
              borderRadius: BorderRadius.circular(5)),
        ),
        hintStyle: GoogleFonts.cairo(
            fontSize: 12, color: MyColors.blackOpacity.withOpacity(.8)),
        labelStyle: context.locale.languageCode != "ar"
            ? GoogleFonts.roboto(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)
            : GoogleFonts.cairo(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        inputStyle: GoogleFonts.cairo(
            fontSize: 12, color: MyColors.blackOpacity.withOpacity(.8)),
      ),
    );
  }
}
