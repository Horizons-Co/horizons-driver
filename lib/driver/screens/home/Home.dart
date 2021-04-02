part of "HomeImports.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final HomeData _homeData = HomeData();

  @override
  void initState() {
    super.initState();
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
        await _homeData.updateUI(data);
      },
    );
    _homeData.initPlatformState();
    bool _isOnline = context.read<UserCubit>().state.model.isOnline;
    _homeData.orderState.onUpdateData(_isOnline);
    if (_homeData.orderState.state.data == true) {
      _homeData.onStart();
    }
  }

  @override
  void dispose() {
    super.dispose();
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
