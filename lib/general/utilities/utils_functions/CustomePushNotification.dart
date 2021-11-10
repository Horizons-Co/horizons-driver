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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_one_signal/flutter_one_signal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomOneSignal {
  static StreamController<String> _onMessageStreamController =
      StreamController.broadcast();

  static initNotification(
      {String merchantId, BuildContext context, HomeData homeData}) async {
    var notificationsPermissionGranted = await FlutterOneSignal.startInit(
      appId: "d66944b7-5bf6-46e1-ae97-ed55adccea38",
      inFocusDisplaying: OSInFocusDisplayOption.Notification,
      notificationReceivedHandler: (data) =>
          onReceiveMessage(data, homeData, context),
      notificationOpenedHandler: (data) =>
          onOpenMessage(data, homeData, context),
    );

    print(
        'Push notification permission granted $notificationsPermissionGranted');
    FlutterOneSignal.setSubscription(true);

    var userId = await FlutterOneSignal.getUserId();
    // print("Received $userId");
    handleAndroid(merchantId, userId, context);
  }

  static onReceiveMessage(
      notification, HomeData homeData, BuildContext context) {
    print('received : ${notification.runtimeType}');
    var data = json.decode(notification)["payload"]["rawPayload"];
    var order = data['custom'];
    if (order["a"]["driver"] != null) {
      onDriverReceived(notification, homeData, context);
    } else {
      onOrderReceived(
          notification, homeData.tabController, context, homeData, false);
    }
  }

  static onOrderReceived(notification, TabController tabController,
      BuildContext context, HomeData homeData, bool open) {
    var data = json.decode(notification)["payload"]["rawPayload"];
    var order = data['custom'];
    print("order is $order");
    var orderID = order['a']['order']['id'];
    print("orderID is $orderID");
    GlobalState.instance.set("currentOrderId", orderID);
    print("context is ${order["a"]["order"]["to"]}");
    if (order['a']['order']["status_id"] == 6 && open == false) {
      print(
          "sadasd ${DateTime.now().difference(DateTime.parse(order["a"]["order"]["assigned_at"])).inSeconds >= 120}");
      if (DateTime.now()
              .difference(DateTime.parse(order["a"]["order"]["assigned_at"]))
              .inSeconds >=
          120) {
        PlayNotificationSound.playSound();
        _onMessageStreamController.add("refresh");
      } else {
        homeData.timer.onUpdateData(120 -
            DateTime.now()
                .difference(DateTime.parse(order["a"]["order"]["assigned_at"]))
                .inSeconds);
        LoadingDialog.showNotifyDialog(
          timer: homeData.timer,
          context: context,
          deliveryLat: order["a"]["order"]["to"]["lat"],
          deliveryLng: order["a"]["order"]["to"]["lng"],
          assignedAt: DateTime.parse(order["a"]["order"]["assigned_at"]),
          deliveryTo: order["a"]["order"]["is_multiple"] == true
              ? tr("store")
              : order["a"]["order"]["to"]["district"],
          receiveFrom: order["a"]["order"]["from"]["district"],
          receiveLat: order["a"]["order"]["from"]["lng"],
          receiveLng: order["a"]["order"]["from"]["lng"],
          tax: order["a"]["order"]["delivery_fees_with_tax"],
          total: order["a"]["order"]["price"],
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
      }
    } else
      _onMessageStreamController.add("refresh");

    // _onMessageStreamController.add("notification");
  }

  static onDriverReceived(
      notification, HomeData homeData, BuildContext context) {
    var data = json.decode(notification)["payload"]["rawPayload"];
    var order = data['custom'];
    UserModel user = UserModel.fromJson(order["a"]["driver"]);
    context.read<UserCubit>().onUpdateUserData(user);
    homeData.changeActiveStateFromNotify(
        context: context,
        active: (user.isActive && !user.suspended && user.isOnline));
    String title = data["aps"]["alert"]["title"];
    String body = data["aps"]["alert"]["body"];
    BotToast.showNotification(
      onTap: () => onclickMessage(notification, homeData.tabController),
      title: (_) => MyText(
        title: title,
        size: 12,
        color: MyColors.primary,
      ),
      subtitle: (_) => MyText(
        title: body,
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
    var data = json.decode(notification)["payload"]["rawPayload"];

    var order = data['custom'];
    if (order["a"]["driver"] != null) {
      onDriverReceived(notification, homeData, context);
    } else {
      onOrderReceived(
          notification, homeData.tabController, context, homeData, true);
    }
  }

  static onclickMessage(notification, TabController tabController) {
    print('opened : $notification');
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

  static void changeOrderState(BuildContext context, notification,
      TabController tabController, String state) async {
    closeDialog(context);
    var data = json.decode(notification)["payload"]["rawPayload"];

    var order = data['custom'];
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
    // Navigator.pop(context);
    PlayNotificationSound.stopSound();
  }
}
