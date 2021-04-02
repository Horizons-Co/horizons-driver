part of "HomeImports.dart";

class HomeData {
  static const String isolateName = 'LocatorIsolate';
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  final GenericCubit<bool> orderState = GenericCubit(false);
  final GenericCubit<bool> isRunning = GenericCubit(false);
  TabController tabController;
  ReceivePort port = ReceivePort();
  LocationDto lastLocation;
  DateTime lastTimeLocation;

  void changeActiveState({bool active, BuildContext context}) async {
    bool _changed = await DriverRepository(context).changeNotify(active);
    if (_changed) {
      if (active == true) {
        onStart();
        orderState.onUpdateData(active);
      } else {
        onStop();
        orderState.onUpdateData(active);
      }
    }
  }

  Future<void> updateUI(LocationDto data) async {
    await _updateNotificationText(data);
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();

    print('Running ${isRunning.toString()}');
  }

  void onStart() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();
    } else {
      // show error
    }
  }

  void onStop() async {
    BackgroundLocator.unRegisterLocationUpdate();

    final _isRunning = await BackgroundLocator.isServiceRunning();

    isRunning.onUpdateData(_isRunning);
  }

  Future<bool> _checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
        break;
      case PermissionStatus.granted:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  void _startLocator() {
    Map<String, dynamic> data = {
      "userID": GlobalState.instance.get("userId"),
      "token": GlobalState.instance.get("token")
    };
    BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: data,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      iosSettings: IOSSettings(
          accuracy: LocationAccuracy.NAVIGATION,
          distanceFilter: 0,
          showsBackgroundLocationIndicator: true),
      autoStop: false,
      androidSettings: AndroidSettings(
          accuracy: LocationAccuracy.NAVIGATION,
          interval: 5,
          distanceFilter: 0,
          client: LocationClient.google,
          androidNotificationSettings: AndroidNotificationSettings(
              notificationChannelName: 'Location tracking',
              notificationTitle: 'Start Location Tracking',
              notificationMsg: 'Track location in background',
              notificationBigMsg:
                  'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
              notificationIcon: 'launcher_icon',
              notificationIconColor: Colors.grey,
              notificationTapCallback:
                  LocationCallbackHandler.notificationCallback),
          wakeLockTime: 10),
    );
  }
}
