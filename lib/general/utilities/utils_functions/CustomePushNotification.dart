import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/playSound.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:base_structure/res.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_one_signal/flutter_one_signal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomPushNotification{

  static initNotification({String merchantId, BuildContext context})async{
    var notificationsPermissionGranted = await FlutterOneSignal.startInit(
      appId: "d66944b7-5bf6-46e1-ae97-ed55adccea38",
      inFocusDisplaying: OSInFocusDisplayOption.Notification,
      notificationReceivedHandler: onReceiveMessage,
      notificationOpenedHandler: onOpenMessage,
    );

    print('Push notification permission granted $notificationsPermissionGranted');

    FlutterOneSignal.setSubscription(true);

    var userId = await FlutterOneSignal.getUserId();
    print("Received $userId");
    handleAndroid(merchantId,userId,context);
  }

  static onReceiveMessage(notification){
    print('received : $notification');
    var data = json.decode(notification)["payload"]["rawPayload"];
    BotToast.showNotification(
      onTap: ()=>onOpenMessage(notification),
      title: (_) => MyText(title: data["aps"]["alert"]["title"],size: 14,color: MyColors.primary,),
      subtitle: (_) => MyText(title: data["aps"]["alert"]["body"],size: 12,color: MyColors.black,),
      leading: (_)=> Image.asset(Res.logo,width: 50,height: 50),
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      enableSlideOff: true,
      duration: Duration(seconds: 5)
    );
    var order = data['custom'];
    print("order is ${order['a']['order']['id']}");
    var orderID = order['a']['order']['id'];
    print("orderID is $orderID");
    GlobalState.instance.set("currentOrderId", orderID);
    PlayNotificationSound.playSound();
  }
  static onOpenMessage(notification){
    print('opened : $notification');
    var data = json.decode(notification)["payload"]["rawPayload"];

    var order = data['custom'];
    print("orderssssssssss ${order['a']['order']['status_id']}");
    int orderStatus = order['a']['order']['status_id'];
    if (orderStatus == 3) {
      ExtendedNavigator.root
          .push(Routes.home, arguments: HomeArguments(index: 0));
    } else if (orderStatus == 21) {
      ExtendedNavigator.root
          .push(Routes.home, arguments: HomeArguments(index: 3));
    } else if (orderStatus == 4) {
      ExtendedNavigator.root
          .push(Routes.home, arguments: HomeArguments(index: 1));
    } else if (orderStatus == 5) {
      ExtendedNavigator.root
          .push(Routes.home, arguments: HomeArguments(index: 2));
    } else {
      ExtendedNavigator.root.pushAndRemoveUntil(Routes.home, (route) => false,
          arguments: HomeArguments(index: 0));
    }

  }

  static void handleAndroid(String merchantId,String userId, BuildContext context) async {
    print("player id android : " + userId);
    GlobalState.instance
        .set("oneSignalUserId", userId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("oneSignalUserId", userId);
    if (userId != "null")
      sendDeviceToken(
          merchantId: merchantId,
          oneSignalToken: userId,
          context: context);
    else
      print("null player id cannot send data");
  }

  static void sendDeviceToken({String merchantId, BuildContext context, String oneSignalToken}) async {
    print("start send user token one signal");
    GeneralRepository(context).sendDeviceToken(
        merchantId: merchantId, oneSignalToken: oneSignalToken);
  }


  static Future<void> setLogOut()async{
    await  FlutterOneSignal.setSubscription(false);
  }

}