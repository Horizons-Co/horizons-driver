import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_structure/general/models/user_model.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/playSound.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_one_signal/flutter_one_signal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPushNotification {

  static StreamController<String> _onMessageStreamController =
  StreamController.broadcast();

  static initNotification(
      {String merchantId,
      BuildContext context,
      TabController tabController}) async {
    var notificationsPermissionGranted = await FlutterOneSignal.startInit(
      appId: "d66944b7-5bf6-46e1-ae97-ed55adccea38",
      inFocusDisplaying: OSInFocusDisplayOption.Notification,
      notificationReceivedHandler: (data) =>
          onReceiveMessage(data, tabController, context),
      notificationOpenedHandler: (data) => onOpenMessage(data, tabController),
    );

    print(
        'Push notification permission granted $notificationsPermissionGranted');

    FlutterOneSignal.setSubscription(true);

    var userId = await FlutterOneSignal.getUserId();
    print("Received $userId");
    handleAndroid(merchantId, userId, context);
  }

  static onReceiveMessage(
      notification, TabController tabController, BuildContext context) {
    print('received : $notification');
    var data = json.decode(notification)["payload"]["rawPayload"];
    LoadingDialog.showNotifyDialog(
      context: context,
      title: data["aps"]["alert"]["title"],
      confirm: (){},
    );
    var order = data['custom'];
    print("order is ${order['a']['order']['id']}");
    if (order["a"]["driver"] != null) {
      UserModel user = UserModel.fromJson(order["a"]["driver"]);
      context.read<UserCubit>().onUpdateUserData(user);
    } else {
      var orderID = order['a']['order']['id'];
      print("orderID is $orderID");
      GlobalState.instance.set("currentOrderId", orderID);
    }
    print('playSound');
    PlayNotificationSound.playSound();
    _onMessageStreamController.add("notification");
  }

  static onOpenMessage(notification, TabController tabController) {
    print('opened : $notification');
    BotToast.cleanAll();
    var data = json.decode(notification)["payload"]["rawPayload"];

    var order = data['custom'];
    if (order["a"]["driver"] != null) {
      ExtendedNavigator.root
          .pushAndRemoveUntilPath(Routes.profile, Routes.home);
      return;
    }
    int orderStatus = order['a']['order']['status_id'];
    if (orderStatus == 3) {
      ExtendedNavigator.root.popUntilPath(Routes.home);
      tabController.animateTo(0);
    } else if (orderStatus == 21) {
      ExtendedNavigator.root.popUntilPath(Routes.home);
      tabController.animateTo(3);
    } else if (orderStatus == 4) {
      ExtendedNavigator.root.popUntilPath(Routes.home);
      tabController.animateTo(1);
    } else if (orderStatus == 5) {
      ExtendedNavigator.root.popUntilPath(Routes.home);
      tabController.animateTo(2);
    } else {
      ExtendedNavigator.root.popUntilPath(Routes.home);
      tabController.animateTo(0);
    }
  }

  static void handleAndroid(
      String merchantId, String userId, BuildContext context) async {
    print("player id android : " + userId);
    GlobalState.instance.set("oneSignalUserId", userId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("oneSignalUserId", userId);
    if (userId != "null")
      sendDeviceToken(
          merchantId: merchantId, oneSignalToken: userId, context: context);
    else
      print("null player id cannot send data");
  }

  static void sendDeviceToken(
      {String merchantId, BuildContext context, String oneSignalToken}) async {
    print("start send user token one signal");
    GeneralRepository(context).sendDeviceToken(
        merchantId: merchantId, oneSignalToken: oneSignalToken);
  }

  static Future<void> setLogOut() async {
    await FlutterOneSignal.setSubscription(false);
  }

  StreamController<String> get notificationSubject {
    return _onMessageStreamController;
  }

}

// BotToast.showNotification(
// onTap: ()=>onOpenMessage(notification,tabController),
// title: (_) => MyText(title: data["aps"]["alert"]["title"],size: 12,color: MyColors.primary,),
// subtitle: (_) => MyText(title: data["aps"]["alert"]["body"],size: 10,color: MyColors.black,),
// leading: (_)=> Image.asset(Res.logo,width: 50,height: 50),
// trailing: (cancel) => IconButton(
// icon: Icon(Icons.cancel),
// onPressed: cancel,
// ),
// contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
// enableSlideOff: true,
// duration: Duration(seconds: 4),
// animationDuration:
// Duration(milliseconds: 500),
// animationReverseDuration:
// Duration(milliseconds: 500),
// );
