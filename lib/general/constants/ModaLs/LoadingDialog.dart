import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:base_structure/res.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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

  static showNotifyDialog({
    @required BuildContext context,
    @required String title,
    @required Function confirm,
    @required GenericCubit<int> timer,
    Function onCancel,
    String receiveFrom,
    String deliveryTo,
    String total,
    String tax,
    String receiveLat,
    String receiveLng,
    String deliveryLat,
    String deliveryLng,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _alertTimerDialog(
            title, confirm, context, tr("pullToAccept"), timer,
            bkText: tr("pullToRefuse"),
            onCancel: onCancel,
            deliveryLat: deliveryLat,
            deliveryLng: deliveryLng,
            deliveryTo: deliveryTo,
            receiveFrom: receiveFrom,
            receiveLat: receiveLat,
            receiveLng: receiveLng,
            tax: tax,
            total: total);
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
    final GenericCubit<int> timer = GenericCubit<int>(20);
    return AlertDialog(
      title: MyText(
        title: title,
        size: 16,
        color: MyColors.black,
        alien: TextAlign.center,
      ),
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

  static Widget _alertTimerDialog(
    String title,
    Function confirm,
    BuildContext context,
    String okText,
    GenericCubit<int> timer, {
    String bkText,
    Function onCancel,
    String receiveFrom,
    String deliveryTo,
    String total,
    String tax,
    String receiveLat,
    String receiveLng,
    String deliveryLat,
    String deliveryLng,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: MyText(
        title: tr("newOrder"),
        size: 16,
        color: MyColors.black,
        alien: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<GenericCubit<int>, GenericState<int>>(
            cubit: timer,
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: 120,
                height: 120,
                // padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xffE1402E), width: 10),
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: TweenAnimationBuilder<Duration>(
                  duration: Duration(seconds: state.data),
                  onEnd: () => onCancel(),
                  tween: Tween(
                      begin: Duration(seconds: state.data), end: Duration.zero),
                  builder:
                      (BuildContext context, Duration value, Widget child) {
                    timer.onUpdateData(value.inSeconds);
                    final int minutes = value.inMinutes;
                    final int seconds = value.inSeconds % 60;
                    return CircularStepProgressIndicator(
                      totalSteps: 120,
                      currentStep: state.data,
                      stepSize: 7,
                      selectedColor: Color(0xffE1402E),
                      unselectedColor: MyColors.greyWhite,
                      padding: 0,
                      width: 120,
                      height: 120,
                      child: Center(
                          child: MyText(
                        title:
                            "0$minutes:${seconds < 10 ? "0$seconds" : seconds}",
                        size: 12,
                        color: MyColors.blackOpacity,
                      )),
                    );
                  },
                ),
                // child: MyText(
                //   title:
                //       "${'${((120 - state.data) ~/ 60).toString().padLeft(2, '0')}: ${((120 - state.data) % 60).toString().padLeft(2, '0')}'}",
                //   size: 12,
                //   color: MyColors.blackOpacity,
                // ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: MyColors.grey.withOpacity(.1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: "${tr("receivingFrom")}:",
                      size: 12,
                      color: MyColors.grey,
                    ),
                    MyText(
                      title: receiveFrom ?? "",
                      size: 12,
                      color: MyColors.black,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Utils.openMap(
                        json.encode({
                          "lat": receiveLat,
                          "lng": receiveLng,
                        }),
                        context);
                  },
                  child: Image.asset(
                    Res.location,
                    width: 32,
                    height: 32,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: MyColors.grey.withOpacity(.1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: "${tr("deliveryTo")}:",
                      size: 12,
                      color: MyColors.grey,
                    ),
                    MyText(
                      title: deliveryTo ?? "",
                      size: 12,
                      color: MyColors.black,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Utils.openMap(
                        json.encode({
                          "lat": deliveryLat,
                          "lng": deliveryLng,
                        }),
                        context);
                  },
                  child: Image.asset(
                    Res.location,
                    width: 32,
                    height: 32,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: "${tr("orderValue")}:",
                    size: 12,
                    color: MyColors.grey,
                  ),
                  MyText(
                    title: total ?? "",
                    size: 12,
                    color: MyColors.black,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: "${tr("deliveryFees")}:",
                    size: 12,
                    color: MyColors.grey,
                  ),
                  MyText(
                    title: tax ?? "",
                    size: 12,
                    color: MyColors.black,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      actions: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Builder(
            builder: (context) {
              final GlobalKey<SlideActionState> _key = GlobalKey();
              return SlideAction(
                key: _key,
                innerColor: Colors.transparent,
                outerColor: Colors.blueAccent,
                reversed: true,
                submittedIcon: Icon(
                  Icons.done,
                  color: MyColors.white,
                ),
                sliderButtonIcon: Icon(Icons.arrow_back, color: MyColors.white),
                borderRadius: 16,
                animationDuration: Duration(milliseconds: 500),
                height: 50,
                child: MyText(
                  title: okText,
                  size: 14,
                  color: MyColors.white,
                ),
                onSubmit: () {
                  // _timer.cancel();
                  confirm();
                },
              );
            },
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 10),
          child: Builder(
            builder: (context) {
              final GlobalKey<SlideActionState> _key = GlobalKey();
              return SlideAction(
                key: _key,
                innerColor: Colors.transparent,
                outerColor: Colors.red,
                reversed: false,
                submittedIcon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                sliderButtonIcon: Icon(Icons.arrow_back, color: MyColors.white),
                borderRadius: 16,
                animationDuration: Duration(milliseconds: 300),
                height: 50,
                child: MyText(
                  title: bkText,
                  size: 14,
                  color: MyColors.white,
                ),
                onSubmit: () {
                  // _timer.cancel();
                  onCancel();
                },
              );
            },
          ),
        ),

        // TextButton(
        //   child: MyText(
        //     title: bkText ?? tr("login"),
        //     size: 14,
        //     color: MyColors.headerColor,
        //   ),
        //   onPressed: () {
        //     _timer.cancel();
        //     onCancel();
        //   },
        // ),
        // TextButton(
        //   child: MyText(
        //     title: okText,
        //     size: 14,
        //     color: MyColors.headerColor,
        //   ),
        //   onPressed: confirm,
        // ),
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
