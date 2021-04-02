import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class CustomOneSignal {
  static Future<void> initPlatformState(
      String merchantId, BuildContext context) async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setRequiresUserPrivacyConsent(false);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      print(
          "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      int orderStatus =
          notification.payload.rawPayload['custom']['a']['order']['status_id'];
      var orderId = notification
          .payload.rawPayload['custom']['a']['order']['id']
          .toString();
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print(
          "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      int orderStatus = result.notification.payload.rawPayload['custom']['a']
          ['order']['status_id'];

      var orderId = result
          .notification.payload.rawPayload['custom']['a']['order']['id']
          .toString();
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
    });

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

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .init("d66944b7-5bf6-46e1-ae97-ed55adccea38", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    await OneSignal.shared.requiresUserPrivacyConsent();

    handleAndroid(merchantId, context);
  }

  static void handleAndroid(String merchantId, BuildContext context) async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    print("player id android : " + status.subscriptionStatus.userId);
    if (status.subscriptionStatus.userId != "null")
      sendDeviceToken(
          merchantId: merchantId,
          oneSignalToken: status.subscriptionStatus.userId,
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
}