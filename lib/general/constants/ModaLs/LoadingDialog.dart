import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/MyText.dart';
import '../MyColors.dart';

class LoadingDialog {
  static showLoadingDialog() {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
        indicator: SpinKitCubeGrid(
          size: 40.0,
          itemBuilder: (context, index) {
            return Container(
              height: 10,
              width: 10,
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: MyColors.primary, shape: BoxShape.circle),
            );
          },
        ),
        status: "loading");
  }

  static showLoadingView() {
    return SpinKitCubeGrid(
      color: MyColors.primary,
      size: 40.0,
    );
  }

  static showLoadingViewWhite() {
    return SpinKitCubeGrid(
      color: MyColors.headerColor,
      size: 40.0,
    );
  }

  static showConfirmDialog(
      {@required BuildContext context,
      @required String title,
      @required Function confirm}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(title, confirm, context, tr("confirm"));
      },
    );
  }

  static showSettingDialog(
      {@required BuildContext context,
      @required String title,
      @required Function confirm}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(title, confirm, context, tr("settings"),
            bkText: tr("cancel"));
      },
    );
  }

  static showNotifyDialog(
      {@required BuildContext context,
      @required String title,
      @required Function confirm,
      Function onCancel}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _alertDialog(title, confirm, context, tr("accept"),
            bkText: tr("cancel"), onCancel: onCancel);
      },
    );
  }

  static showAuthDialog({@required BuildContext context}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(
            tr("loginToFollow"),
            () => ExtendedNavigator.of(context).popUntilPath(Routes.login),
            context,
            tr("login"));
      },
    );
  }

  static Widget _alertDialog(
      String title, Function confirm, BuildContext context, String okText,
      {String bkText, Function onCancel}) {
    return AlertDialog(
      title: MyText(
        title: title,
        size: 16,
        color: MyColors.black,
        alien: TextAlign.center,
      ),
      // content: MyText(title: title,size: 12,color: MyColors.blackOpacity,),
      actions: [
        TextButton(
          child: MyText(
            title: bkText ?? tr("login"),
            size: 14,
            color: MyColors.headerColor,
          ),
          onPressed: onCancel ?? () => Navigator.pop(context),
        ),
        TextButton(
          child: MyText(
            title: okText,
            size: 14,
            color: MyColors.headerColor,
          ),
          onPressed: confirm,
        ),
      ],
    );
  }

  static showToastNotification(msg,
      {Color color, Color textColor, Alignment alignment}) {
    BotToast.showSimpleNotification(
        title: msg,
        align: alignment ?? Alignment.bottomCenter,
        backgroundColor: color ?? MyColors.notifyColor,
        titleStyle: TextStyle(color: textColor ?? MyColors.white),
        duration: Duration(seconds: 3),
        hideCloseButton: false,
        closeIcon: Icon(
          Icons.close,
          size: 25,
          color: MyColors.white,
        ));
  }

  static showSimpleToast(msg) {
    BotToast.showText(
        text: msg,
        duration: Duration(milliseconds: 2000),
        textStyle: GoogleFonts.cairo(fontSize: 14, color: MyColors.white));
  }
}
