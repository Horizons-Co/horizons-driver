import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utilities/utils_functions/UtilsImports.dart';

class GlobalNotification {
  // static StreamController<Map<String, dynamic>> _onMessageStreamController =
  //     StreamController.broadcast();

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  int _id = 0;
  bool show = true;
  BuildContext _context;
  static GlobalNotification instance = new GlobalNotification._();

  GlobalNotification._();

  GlobalNotification();

  setupNotification({BuildContext context}) {
    _context = context;
    _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/launcher_icon");
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: flutterNotificationClick,
    );
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        _id++;
        print("_____________________$message");
        _showLocalNotification(message, _id);
        // _onMessageStreamController.add(message);
        String _key = Platform.isIOS ? "notification" : "data";
        if (int.parse(message[_key]["type"]) == -1) {
          Utils.clearSavedData();
          ExtendedNavigator.of(context).push(Routes.login);
        }
        return;
      },
      onResume: (Map<String, dynamic> message) {
        // onSelectNotification(message);
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        // onSelectNotification(message);
        return;
      },
    );
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

  // StreamController<Map<String, dynamic>> get notificationSubject {
  //   return _onMessageStreamController;
  // }

  _showLocalNotification(message, id) async {
    // var provider= navigatorKey.currentContext.read<NotifyProvider>();
    // provider.setNotifyCount(provider.count+1);
    var _notify = message["notification"];
    if (Platform.isAndroid) {
      _notify = message["data"];
    }
    var android = AndroidNotificationDetails(
      "${DateTime.now()}",
      "${_notify["title"]}",
      "${_notify["body"]}",
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      shortcutId: "$_id",
    );
    var ios = IOSNotificationDetails();
    var _platform = NotificationDetails(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.show(
        id, "سلعة", "${_notify["body"]}", _platform,
        payload: json.encode(message));
  }

  Future flutterNotificationClick(payload) async {
    var obj = payload;
    if (payload is String) {
      obj = json.decode(payload);
    }

    var _data;
    if (Platform.isIOS) {
      _data = obj["notification"];
    } else {
      _data = obj["data"];
    }
    print("tttttttttt $_data");
    int _type = int.parse(_data["type"]);

    // if (_type >= 1 && _type <= 4) {
    //   var adInfo= json.decode(_data["ads_info"]);
    //   ExtendedNavigator.root.push(Routes.productDetails,
    //       arguments: ProductDetailsArguments(model: model));
    // } else if(_type >4) {
    //   ExtendedNavigator.root.push(Routes.home);
    // }
  }
}
