import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/driver/repository/DriverRepository.dart';
import 'package:base_structure/driver/screens/home/HomeImports.dart';
import 'package:base_structure/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/models/user_model.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/playSound.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:base_structure/res.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomOneSignal {
  static StreamController<String> _onMessageStreamController =
      StreamController.broadcast();

  static Future<void> initNotification(
      {String merchantId, BuildContext context, HomeData homeData}) async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    };

    await OneSignal.shared
        .init("d66944b7-5bf6-46e1-ae97-ed55adccea38", iOSSettings: settings);
    OneSignal.shared.setRequiresUserPrivacyConsent(false);
    await OneSignal.shared.setSubscription(true);

    OneSignal.shared.setNotificationReceivedHandler(
        (OSNotification notification) =>
            onReceiveMessage(notification, homeData, context));

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) =>
            onOpenMessage(result.notification, homeData, context));

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

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    await OneSignal.shared.requiresUserPrivacyConsent();

    var status = await OneSignal.shared.getPermissionSubscriptionState();
    print("player id android : " + status.subscriptionStatus.userId);
    String userId = status.subscriptionStatus.userId;

    handleAndroid(merchantId, userId, context);
  }

  static onReceiveMessage(
      notification, HomeData homeData, BuildContext context) {
    print('received : $notification');
    var order = Platform.isAndroid
        ? json.decode("${notification.payload.rawPayload['custom']}")
        : notification.payload.rawPayload['custom'];
    if (order["a"]["driver"] != null) {
      onDriverReceived(notification, homeData, context);
    } else {
      onOrderReceived(notification, homeData.tabController, context, homeData);
    }
  }

  static onOrderReceived(notification, TabController tabController,
      BuildContext context, HomeData homeData) {
    var data = notification.payload.rawPayload;
    var order = Platform.isAndroid
        ? json.decode("${notification.payload.rawPayload['custom']}")
        : data['custom'];
    print("order is $data");
    var orderID = order['a']['order']['id'];
    print("orderID is $orderID");
    GlobalState.instance.set("currentOrderId", orderID);
    print("context is ${order["a"]["order"]["to"]}");
    if (order['a']['order']["status_id"] == 6) {
      homeData.timer.onUpdateData(20);
      LoadingDialog.showNotifyDialog(
        timer: homeData.timer,
        context: context,
        deliveryLat: order["a"]["order"]["to"]["lat"],
        deliveryLng: order["a"]["order"]["to"]["lng"],
        deliveryTo: order["a"]["order"]["to"]["district"],
        receiveFrom: order["a"]["order"]["from"]["district"],
        receiveLat: order["a"]["order"]["from"]["lng"],
        receiveLng: order["a"]["order"]["from"]["lng"],
        tax: order["a"]["order"]["delivery_fees_with_tax"],
        total: order["a"]["order"]["total"],
        title: order["title"],
        confirm: () {
          print("cccccccccccccccc");
          closeDialog(context);
          changeOrderState(context, notification, tabController, "4");
        },
        onCancel: () {
          closeDialog(context);
          changeOrderState(context, notification, tabController, "3");
        },
      );
      print('playSound');
      PlayNotificationSound.playSound();
    } else
      _onMessageStreamController.add("refresh");

    // _onMessageStreamController.add("notification");
  }

  static onDriverReceived(
      notification, HomeData homeData, BuildContext context) {
    var data = notification.payload.rawPayload;
    var order = Platform.isAndroid
        ? json.decode("${notification.payload.rawPayload['custom']}")
        : data['custom'];
    UserModel user = UserModel.fromJson(order["a"]["driver"]);
    context.read<UserCubit>().onUpdateUserData(user);
    homeData.changeActiveStateFromNotify(
        context: context,
        active: (user.isActive && !user.suspended && user.isOnline));
    print("hommmmm $data");
    BotToast.showNotification(
      onTap: () => onclickMessage(notification, homeData.tabController),
      title: (_) => MyText(
        title: data["title"],
        size: 12,
        color: MyColors.primary,
      ),
      subtitle: (_) => MyText(
        title: data["alert"],
        size: 10,
        color: MyColors.black,
      ),
      leading: (_) => Image.asset(Res.logo, width: 50, height: 50),
      trailing: (cancel) => IconButton(
        icon: Icon(Icons.cancel),
        onPressed: cancel,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      enableSlideOff: true,
      duration: Duration(seconds: 4),
      animationDuration: Duration(milliseconds: 500),
      animationReverseDuration: Duration(milliseconds: 500),
    );
  }

  static onOpenMessage(notification, HomeData homeData, BuildContext context) {
    print('opened : $notification');
    // var data = json.decode(notification.payload.rawPayload);
    var order = Platform.isAndroid
        ? json.decode("${notification.payload.rawPayload['custom']}")
        : notification.payload.rawPayload['custom'];
    if (order["a"]["driver"] != null) {
      onDriverReceived(notification, homeData, context);
    } else {
      onOrderReceived(notification, homeData.tabController, context, homeData);
    }
  }

  static onclickMessage(notification, TabController tabController) {
    print('opened : $notification');
    // var data = json.decode(notification)["payload"]["rawPayload"];

    var order = Platform.isAndroid
        ? json.decode("${notification.payload.rawPayload['custom']}")
        : notification.payload.rawPayload['custom'];

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
    await OneSignal.shared.setSubscription(false);
  }

  StreamController<String> get notificationSubject {
    return _onMessageStreamController;
  }

  static void changeOrderState(
      BuildContext context,
      OSNotification notification,
      TabController tabController,
      String state) async {
    // closeDialog(context);
    // var data = json.decode(notification)["payload"]["rawPayload"];
    print("notification is ${notification.payload.rawPayload["custom"]}");
    var order = Platform.isAndroid
        ? json.decode("${notification.payload.rawPayload['custom']}")
        : notification.payload.rawPayload['custom'];
    // var order = notification.payload.rawPayload["custom"];
    await DriverRepository(context).changeOrderStatusFromNotify(
        orderId: order['a']['order']['id'], action: state);
    onclickMessage(notification, tabController);
    if (state == "4") _onMessageStreamController.add("refresh");
  }

  static void changeNewOrderState(BuildContext context, String id,
      TabController tabController, String state) async {
    await DriverRepository(context)
        .changeOrderStatusFromNotify(orderId: id, action: state);
    ExtendedNavigator.root.popUntilPath(Routes.home);
    tabController.animateTo(0);
    if (state == "4") _onMessageStreamController.add("refresh");
  }

  static void closeDialog(BuildContext context) {
    Navigator.pop(context);
    PlayNotificationSound.stopSound();
  }
}
