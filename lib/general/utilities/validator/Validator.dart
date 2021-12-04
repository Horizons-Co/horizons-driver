import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension Validator on String {
  String get noValidate {
    return null;
  }

  String validateEmpty({String message}) {
    if (this.trim().isEmpty) {
      return message ?? tr("fillField");
    }
    return null;
  }

  String validatePassword({String message}) {
    if (this.trim().isEmpty) {
      return message ?? tr("fillField");
    } else if (this.length < 6) {
      return message ?? tr("passValidation");
    }
    return null;
  }

  String validateEmail({String message}) {
    if (this.trim().isEmpty) {
      return message ?? tr("fillField");
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this)) {
      return message ?? tr("mailValidation");
    }
    return null;
  }

  String validateEmailORNull({String message}) {
    if (this.trim().isNotEmpty) {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(this)) {
        return message ?? tr("mailValidation");
      }
    }
    return null;
  }

  String validatePhone({String message}) {
    if (this.trim().isEmpty) {
      return message ?? tr("fillField");
    } else if (
        // !RegExp(
        //             r'(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)')
        //         .hasMatch(this) ||
        this.length != 9) {
      return message ?? tr("phoneValidation");
    }
    return null;
  }

  String validatePasswordConfirm({@required String pass, String message}) {
    if (this.trim().isEmpty) {
      return message ?? tr("fillField");
    } else if (this != pass) {
      return message ?? tr("confirmValidation");
    }
    return null;
  }
}

extension ValidatorDrop<DataType> on DataType {
  String validateDropDown({String message}) {
    if (this == null) {
      return message ?? tr("fillField");
    }
    return null;
  }
}
