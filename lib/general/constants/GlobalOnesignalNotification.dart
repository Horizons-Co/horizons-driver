import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void globalNotification(GlobalKey<NavigatorState> navigatorKey) async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("3317b60f-f630-4400-809c-5a213234b751", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {
    // will be called whenever a notification is received

    print("notification received *****");
    print(notification.payload.rawPayload['custom']['a']['order']['id']
        .toString());
    int orderStatus =
        notification.payload.rawPayload['custom']['a']['order']['status_id'];
    var orderId = notification.payload.rawPayload['custom']['a']['order']['id']
        .toString();
    print("notification received *****");
  });

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // a notification has been opened
    print("a notification has been opened");
    int orderStatus = result.notification.payload.rawPayload['custom']['a']
        ['order']['status_id'];
    var orderId = result
        .notification.payload.rawPayload['custom']['a']['order']['id']
        .toString();
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
  });

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // will be called whenever the subscription changes
    //(ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver(
      (OSEmailSubscriptionStateChanges emailChanges) {
    // will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });

// For each of the above functions, you can also pass in a
// reference to a function as well:

  void _handleNotificationReceived(OSNotification notification) {}
}
