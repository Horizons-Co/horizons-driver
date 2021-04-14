part of "HomeImports.dart";

class Home extends StatefulWidget {
  final int index;

  const Home({this.index = 0});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final HomeData _homeData = HomeData();

  @override
  void initState() {
    var user = context.read<UserCubit>().state.model;
    _homeData.orderState.onUpdateData(user.isOnline);
    // print("is online userrrrrrrrrrrrrrrr ${user.isOnline}");
    // print(
    //     "is online orderStateeeeeeeeeeeeee ${_homeData.orderState.state.data}");
    _homeData.tabController = TabController(length: 4, vsync: this);

    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        _homeData.port.sendPort, LocationServiceRepository.isolateName);

    _homeData.port.listen(
      (dynamic data) async {
        // print("dddddddddddddddddddddddddddddd => $data");
        await _homeData.updateUI(data);
      },
    );
    _homeData.initPlatformState();

    if (_homeData.orderState.state.data == true) {
      _homeData.onStart();
    }
    _homeData.tabController.index = widget.index;
    CustomPushNotification.initNotification(
      merchantId: user.id,
      context: context,
      homeData: _homeData,
    );
    // CustomOneSignal.initNotification(
    //   merchantId: user.id,
    //   context: context,
    //   tabController: _homeData.tabController,
    // );
    _homeData.fetchPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
        ));
  }
}
