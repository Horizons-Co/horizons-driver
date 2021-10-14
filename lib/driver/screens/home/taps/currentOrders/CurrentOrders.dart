part of 'CurrentOrdersImports.dart';

class CurrentOrders extends StatefulWidget {
  final HomeData _homeData;

  const CurrentOrders(this._homeData);

  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  final CurrentOrdersData currentOrdersData = CurrentOrdersData();

  @override
  void initState() {
    currentOrdersData.pagingController.addPageRequestListener((pageKey) {
      currentOrdersData.fetchPage(context, pageKey);
    });
    currentOrdersData.streamListener(context, mounted);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.model;
    return BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        cubit: widget._homeData.orderState,
        builder: (_, state) {
          if (state.data == false) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.height * .15,
                  child: Image.asset(Res.noOrders),
                ),
                MyText(
                  title: !user.isActive || user.suspended
                      ? tr("noActive")
                      : tr("noOrders"),
                  size: 12,
                  color: MyColors.grey.withOpacity(.3),
                )
              ],
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                currentOrdersData.pagingController.refresh();
              },
              child: PagedListView<int, OrderItemModel>(
                pagingController: currentOrdersData.pagingController,
                // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(vertical: 10),
                builderDelegate: PagedChildBuilderDelegate<OrderItemModel>(
                    noItemsFoundIndicatorBuilder: (_) => Center(
                          child: MyText(
                            title: tr("noOrders"),
                            size: 12,
                            color: MyColors.primary,
                          ),
                        ),
                    itemBuilder: (context, item, index) => orderItem(
                        orderItemModel: item,
                        context: context,
                        pending: () {
                          if (DateTime.now()
                                  .difference(DateTime.parse(item.assignedAt))
                                  .inSeconds >=
                              120) {
                            PlayNotificationSound.stopSound();
                            currentOrdersData.pagingController.refresh();
                          } else {
                            widget._homeData.timer.onUpdateData(120 -
                                (DateTime.now()
                                    .difference(DateTime.parse(item.assignedAt))
                                    .inSeconds));
                            widget._homeData.showOrderDialog(
                                item.id, context, item.no,
                                tax:
                                    "${num.parse(item.deliveryFees.replaceAll("ر.س.", "")) + num.parse(item.vat.amount.replaceAll("ر.س.", ""))}"
                                    " ${tr("r.s")}",
                                deliveryLng: item.pickupPoint.id == 2
                                    ? item.branch.lng
                                    : item.client.lag,
                                deliveryLat: item.pickupPoint.id == 2
                                    ? item.branch.lat
                                    : item.client.lat,
                                receiveLat: item.pickupPoint.id == 1
                                    ? item.branch.lat
                                    : item.client.lat,
                                receiveLng: item.pickupPoint.id == 1
                                    ? item.branch.lng
                                    : item.client.lag,
                                deliveryTo: item.pickupPoint.id == 2
                                    ? item.branch.district.name
                                    : item.client.district.name,
                                receiveFrom: item.pickupPoint.id == 1
                                    ? item.branch.district.name
                                    : item.client.district.name,
                                total: item.price + item.currency);
                          }
                        })),
              ),
            );
          }
        });
  }
}
