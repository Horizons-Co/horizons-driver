import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/models/user_model.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/playSound.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:base_structure/res.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomOneSignal {

  static Future<void> initNotification({String merchantId, BuildContext context,TabController tabController}) async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);


    var settings = {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    };
    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .init("d66944b7-5bf6-46e1-ae97-ed55adccea38", iOSSettings: settings);
    OneSignal.shared.setRequiresUserPrivacyConsent(false);

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification)=>
        onReceiveMessage(notification,tabController,context));

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) => onOpenMessage(result.notification,tabController));

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      print(
          "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}");
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges changes) {
      print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });


    await OneSignal.shared.setSubscription(true);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    await OneSignal.shared.requiresUserPrivacyConsent();

    handleAndroid(merchantId, context);
  }


  static onReceiveMessage(notification,TabController tabController,BuildContext context){
    print('received : $notification');
    var data = json.decode(notification.payload.rawPayload);
    BotToast.showNotification(
      onTap: ()=>onOpenMessage(notification,tabController),
      title: (_) => MyText(title: data["aps"]["alert"]["title"],size: 12,color: MyColors.primary,),
      subtitle: (_) => MyText(title: data["aps"]["alert"]["body"],size: 10,color: MyColors.black,),
      leading: (_)=> Image.asset(Res.logo,width: 50,height: 50),
      trailing: (cancel) => IconButton(
        icon: Icon(Icons.cancel),
        onPressed: cancel,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      enableSlideOff: true,
      duration: Duration(seconds: 4),
      animationDuration:
      Duration(milliseconds: 500),
      animationReverseDuration:
      Duration(milliseconds: 500),
    );
    var order = json.decode(notification.payload.rawPayload['custom']);
    print("order is ${order['a']['order']['id']}");
    if(order["a"]["driver"]!=null){
      UserModel user = UserModel.fromJson(order["a"]["driver"]);
      context.read<UserCubit>().onUpdateUserData(user);
    }else{
      var orderID = order['a']['order']['id'];
      print("orderID is $orderID");
      GlobalState.instance.set("currentOrderId", orderID);
    }

    print('playSound');
    PlayNotificationSound.playSound();
  }

  static onOpenMessage(notification,TabController tabController){
    print('opened : $notification');
    BotToast.cleanAll();
    var data = json.decode(notification.payload.rawPayload);

    var order = json.decode(notification.payload.rawPayload['custom']);
    if(order["a"]["driver"]!=null){
      ExtendedNavigator.root.pushAndRemoveUntilPath(Routes.profile,Routes.home);
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

  static void handleAndroid(String merchantId, BuildContext context) async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    print("player id android : " + status.subscriptionStatus.userId);
    String userId = status.subscriptionStatus.userId;
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

  static void sendDeviceToken(
      {String merchantId, BuildContext context, String oneSignalToken}) async {
    print("start send user token one signal");
    GeneralRepository(context).sendDeviceToken(
        merchantId: merchantId, oneSignalToken: oneSignalToken);
  }

  static Future<void> setLogOut()async{
    await  OneSignal.shared.setSubscription(false);;
  }

}
