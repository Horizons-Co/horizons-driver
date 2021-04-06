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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  title: tr("noOrders"),
                  size: 12,
                  color: MyColors.grey.withOpacity(.3),
                )
              ],
            );
          } else {
            return PagedListView<int, OrderItemModel>(
              pagingController: currentOrdersData.pagingController,
              padding: const EdgeInsets.symmetric(vertical: 10),
              builderDelegate: PagedChildBuilderDelegate<OrderItemModel>(
                  noItemsFoundIndicatorBuilder: (_) => Center(
                        child: MyText(
                          title: tr("noOrders"),
                          size: 12,
                          color: MyColors.primary,
                        ),
                      ),
                  itemBuilder: (context, item, index) =>
                      orderItem(orderItemModel: item, context: context)),
            );
          }
        });
  }
}
