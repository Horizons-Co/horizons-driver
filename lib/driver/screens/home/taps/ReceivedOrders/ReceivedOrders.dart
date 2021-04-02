part of 'ReceivedOrdersImports.dart';

class ReceivedOrders extends StatefulWidget {
  @override
  _ReceivedOrdersState createState() => _ReceivedOrdersState();
}

class _ReceivedOrdersState extends State<ReceivedOrders> {
  final ReceivedOrdersData _receivedOrdersData = ReceivedOrdersData();

  @override
  void initState() {
    _receivedOrdersData.pagingController.addPageRequestListener((pageKey) {
      _receivedOrdersData.fetchPage(context, pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, OrderItemModel>(
      pagingController: _receivedOrdersData.pagingController,
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
