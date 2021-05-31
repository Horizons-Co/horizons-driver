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
  bool notifyDialog=false;
  bool locDialog=false;

  void fetchPage(BuildContext context) async {
    var orders = await DriverRepository(context).getNewOrders();
    if(orders.length>0){
      showOrderDialog(orders.last.id,context,orders.last.no);
    }
  }

  void showOrderDialog(String id,BuildContext context,int no){
    LoadingDialog.showNotifyDialog(
      context: context,
      title: "تم إسناد الطلب رقم $no",
      confirm: ()=>CustomOneSignal.changeNewOrderState(context,id,tabController,"4"),
      onCancel: ()=>CustomOneSignal.changeNewOrderState(context,id,tabController,"3"),
      // confirm: ()=>CustomPushNotification.changeNewOrderState(context,id,tabController,"4"),
      // onCancel: ()=>CustomPushNotification.changeNewOrderState(context,id,tabController,"3"),
    );
    GlobalState.instance.set("currentOrderId", id);
    print('playSound');
    PlayNotificationSound.playSound();
  }


  void changeActiveState({bool active, BuildContext context}) async {
    var user = context.read<UserCubit>().state.model;
    if(user.isActive&&!user.suspended){
      bool _changed = await DriverRepository(context).changeNotify(active);
      if (_changed) {
        if (active == true) {
          onStart(context);
          orderState.onUpdateData(active);
        } else {
          onStop();
          orderState.onUpdateData(active);
        }
      }
    }else{
      LoadingDialog.showToastNotification(tr("noOrdersUntilActive"));
    }

  }

  Future<void> changeActiveStateFromNotify({bool active, BuildContext context}) async {
    bool _changed = await DriverRepository(context).changeNotify(active);
    if (_changed) {
      if (active == true) {
        onStart(context);
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
    isRunning.onUpdateData(_isRunning);
    print('Running ${isRunning.toString()}');
  }

  void onStart(BuildContext context) async {
    var result = await checkLocationPermission();
    if (result) {
      await startLocator();
      await BackgroundLocator.isServiceRunning();
    } else {
      observeLocationStatus(context);
    }
  }

  void onStop() async {
    BackgroundLocator.unRegisterLocationUpdate();

    final _isRunning = await BackgroundLocator.isServiceRunning();

    isRunning.onUpdateData(_isRunning);
  }

  static Future<bool> checkLocationPermission() async {
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

  Future<void> startLocator()async {
    Map<String, dynamic> data = {
      "userID": GlobalState.instance.get("userId"),
      "token": GlobalState.instance.get("token")
    };
    await BackgroundLocator.registerLocationUpdate(
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


  observeLocationStatus(BuildContext context){
    checkLocationPermission().then((value) {
      if(!value&&!locDialog){
        LocationPermissions().requestPermissions().then((result){
          if(result!=PermissionStatus.granted){
            locDialog=true;
            LoadingDialog.showSettingDialog(
              context: context,
              title: tr("pleaseActiveLoc"),
              confirm: (){
                Navigator.of(context).pop();
                locDialog=false;
                AppSettings.openLocationSettings();
              },
            );
          }
        });
      }
    });
  }

  observeNotificationStatus(BuildContext context){
    OneSignal.shared.promptUserForPushNotificationPermission().then((value){
      if(!value&&!notifyDialog){
        notifyDialog=true;
        LoadingDialog.showSettingDialog(
          context: context,
          title: tr("pleaseActiveNotify"),
          confirm: (){
            Navigator.of(context).pop();
            notifyDialog=false;
            AppSettings.openNotificationSettings();
          },
        );
      }
    });
  }

}
