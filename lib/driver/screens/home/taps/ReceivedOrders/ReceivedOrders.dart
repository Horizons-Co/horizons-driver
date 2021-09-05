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
    var user = context.watch<UserCubit>().state.model;
    return RefreshIndicator(
      onRefresh: () async {
        _receivedOrdersData.pagingController.refresh();
      },
      child: PagedListView<int, OrderItemModel>(
        // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(vertical: 10),
        pagingController: _receivedOrdersData.pagingController,
        builderDelegate: PagedChildBuilderDelegate<OrderItemModel>(
            noItemsFoundIndicatorBuilder: (_) => Center(
                  child: MyText(
                    title: user.isActive ? tr("noOrders") : tr("noActive"),
                    size: 12,
                    color: MyColors.primary,
                  ),
                ),
            itemBuilder: (context, item, index) => orderItem(orderItemModel: item, context: context)),
      ),
    );
  }
}
