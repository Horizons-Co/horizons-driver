part of 'DrawerImports.dart';

class DriverDrawer extends StatelessWidget {
  final HomeData _homeData;
  DriverDrawer(this._homeData);

  final DrawerData _drawerData = DrawerData();

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.model;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 50),
        physics: const BouncingScrollPhysics(
          parent: const AlwaysScrollableScrollPhysics(),
        ),
        children: [
          // CachedImage(
          //   url:
          //       "https://www.google.com.eg/search?q=person+icon&hl=en&authuser=0&tbm=isch&sxsrf=ALeKk00ezIAdLtE4C5WulQierdZF1HOPzA%3A1616267024957&source=hp&biw=502&bih=738&ei=EEdWYIrgN86Wa62Rj0A&oq=person&gs_lcp=CgNpbWcQAxgBMgUIABCxAzICCAAyAggAMgIIADICCAAyAggAMgIIADICCAAyAggAMgIIADoHCCMQ6gIQJzoECCMQJzoICAAQsQMQgwFQ7gVYwhlgtihoA3AAeACAAeoBiAG3B5IBBTAuNS4xmAEAoAEBqgELZ3dzLXdpei1pbWewAQo&sclient=img#imgrc=dBuDwM0wZV5etM",
          //   height: 55,
          //   width: 55,
          // ),
          BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
              cubit: _homeData.orderState,
              builder: (_, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MyText(
                        title: tr("status"),
                        size: 9,
                        color: MyColors.black,
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
                      Spacer(),
                      Switch(
                          inactiveThumbColor: MyColors.white,
                          inactiveTrackColor: MyColors.grey,
                          activeTrackColor: Colors.green,
                          activeColor: MyColors.white,
                          value: state.data ?? false,
                          onChanged: (bool value) =>
                              _homeData.changeActiveState(
                                  context: context, active: value))
                    ],
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(user.personalImage ?? ""),
                        fit: BoxFit.fill)),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: tr("hello"),
                  color: MyColors.black,
                  size: 14,
                  alien: TextAlign.start,
                  fontWeight: FontWeight.w600,
                ),
                MyText(
                  title: user.name ?? "",
                  color: MyColors.black,
                  size: 16,
                  alien: TextAlign.start,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  children: [
                    MyText(
                      title: user.mobile ?? "",
                      overflow: TextOverflow.clip,
                      color: MyColors.blackOpacity,
                      size: 12,
                      alien: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // DrawerWallet(
          //   wallet: "رصيدي",
          //   price: " SAR 243.12",
          // ),
          DrawerItemCard(
            title: tr("myInfo"),
            color: MyColors.black,
            icon: Res.personInfo,
            onTap: () => setNavigationFunc(context, Routes.profile),
          ),
          DrawerItemCard(
            title: tr("customerService"),
            color: MyColors.black,
            icon: Res.contactUs,
            onTap: () => setNavigationFunc(context, Routes.contactUs),
          ),
          DrawerItemCard(
            title: tr("language"),
            icon: Res.translation,
            color: MyColors.black,
            onTap: () => setNavigationFunc(context, Routes.language),
          ),
          // DrawerItemCard(
          //   title: "الإشعارات",
          //   color: MyColors.black,
          //   icon: Res.notification,
          // ),
          DrawerItemCard(
            title: tr("logout"),
            color: Colors.red,
            icon: Res.logout,
            onTap: () => _drawerData.showLogoutAlert(
                acceptTitle: tr("logout"),
                onAccept: () async {
                  GeneralRepository(context).logout(_homeData);
                },
                context: context,
                title: tr("areYouSureToLogout")),
          ),
          Image.asset(
            Res.logoWhite,
            width: 150,
            height: 80,
            // fit: BoxFit.contain,
          ),
          MyText(
            title: "Version 1.0.29",
            color: MyColors.black,
            size: 8,
            alien: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void setNavigationFunc(BuildContext context, String route) {
    // ExtendedNavigator.root.pop();
    ExtendedNavigator.root.push(route);
  }
}
