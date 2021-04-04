part of 'HomeWidgetsImports.dart';

class HomeAppBar extends PreferredSize {
  final BuildContext context;
  final HomeData homeData;
  final Size preferredSize = const Size.fromHeight(kToolbarHeight * 2);

  const HomeAppBar({this.context, this.homeData});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.headerColor,
      elevation: 0,
      title: Image.asset(Res.icon),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: ImageIcon(
            AssetImage(Res.menu),
            size: 25,
            color: MyColors.white,
          ),
          onPressed: () => homeData.scaffold.currentState.openDrawer()),
      actions: [
        BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
            cubit: homeData.orderState,
            builder: (_, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    title: tr("status"),
                    size: 9,
                    color: MyColors.white,
                  ),
                  Visibility(
                    visible: state.data,
                    child: MyText(
                      title: tr("available"),
                      size: 8,
                      color: MyColors.grey,
                    ),
                    replacement: MyText(
                      title: tr("unAvailable"),
                      size: 8,
                      color: Colors.red,
                    ),
                  ),
                  Switch(
                      inactiveThumbColor: MyColors.white,
                      inactiveTrackColor: MyColors.white,
                      activeTrackColor: Colors.green,
                      activeColor: MyColors.white,
                      value: state.data ?? false,
                      onChanged: (bool value) {
                        homeData.changeActiveState(
                            context: context, active: value);
                      })
                ],
              );
            })
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: MyColors.greyWhite, width: .5),
                  top: BorderSide(color: MyColors.greyWhite, width: .5))),
          child: TabBar(
            controller: homeData.tabController,
            indicator: BoxDecoration(color: MyColors.greyWhite),
            unselectedLabelColor: MyColors.white,
            labelColor: MyColors.white,
            labelPadding: const EdgeInsets.all(0),
            indicatorPadding: const EdgeInsets.all(0),
            onTap: (index) {
              homeData.tabController.index = index;
            },
            tabs: [
              TabItem(
                title: tr("currentOrders"),
                showBadge: false,
              ),
              TabItem(
                title: tr("hasReceived"),
                showBadge: false,
                count: "5",
              ),
              TabItem(
                title: tr("hasDelivered"),
                showBadge: false,
              ),
              TabItem(
                showBadge: false,
                title: tr("canceled"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
