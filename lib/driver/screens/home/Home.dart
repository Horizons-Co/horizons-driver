part of "HomeImports.dart";

class Home extends StatefulWidget {
  final int index;

  const Home({this.index = 0});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final HomeData _homeData = HomeData();

  @override
  void initState() {
    var user = context.read<UserCubit>().state.model;
    _homeData.tabController = TabController(length: 4, vsync: this);
    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }
    WidgetsBinding.instance.addObserver(this);
    IsolateNameServer.registerPortWithName(
        _homeData.port.sendPort, LocationServiceRepository.isolateName);

    _homeData.port.listen((dynamic data) async {
      await _homeData.updateUI(data);
    });
    _homeData.initPlatformState();

    if (_homeData.orderState.state.data == true) {
      _homeData.onStart(context);
    }
    _homeData.tabController.index = widget.index;
    CustomOneSignal.initNotification(
      merchantId: user.id,
      context: context,
      homeData: _homeData,
    );
    _homeData.fetchPage(context);
    _homeData.observeNotificationStatus(context);
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _homeData.observeLocationStatus(context);
      _homeData.observeNotificationStatus(context);
      _homeData.fetchPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: MyColors.headerColor,
            key: _homeData.scaffold,
            drawer: DriverDrawer(_homeData),
            appBar: HomeAppBar(
              context: context,
              homeData: _homeData,
            ),
            body: TabBarView(
              controller: _homeData.tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CurrentOrders(_homeData),
                ReceivedOrders(),
                DeliveredOrders(),
                CanceledOrders()
              ],
            ),
          )),
      onWillPop: () async => false,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
