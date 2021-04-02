part of 'CanceledOrdersImports.dart';

class CanceledOrders extends StatefulWidget {
  @override
  _CanceledOrdersState createState() => _CanceledOrdersState();
}

class _CanceledOrdersState extends State<CanceledOrders> {
  final CanceledOrdersData canceledOrdersData = new CanceledOrdersData();

  @override
  void initState() {
    canceledOrdersData.pagingController.addPageRequestListener((pageKey) {
      canceledOrdersData.fetchPage(context, pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, OrderItemModel>(
      pagingController: canceledOrdersData.pagingController,
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
}
