part of 'DeliveredOrdersImports.dart';

class DeliveredOrders extends StatefulWidget {
  @override
  _DeliveredOrdersState createState() => _DeliveredOrdersState();
}

class _DeliveredOrdersState extends State<DeliveredOrders> {
  final DeliveredOrdersData _deliveredOrdersData = DeliveredOrdersData();
  @override
  void initState() {
    _deliveredOrdersData.pagingController.addPageRequestListener((pageKey) {
      _deliveredOrdersData.fetchPage(context, pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, OrderItemModel>(
      pagingController: _deliveredOrdersData.pagingController,
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
