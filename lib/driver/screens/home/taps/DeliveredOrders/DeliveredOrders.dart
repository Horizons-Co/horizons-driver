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
    var user = context.watch<UserCubit>().state.model;
    return PagedListView<int, OrderItemModel>(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(vertical: 10),
      pagingController: _deliveredOrdersData.pagingController,
      builderDelegate: PagedChildBuilderDelegate<OrderItemModel>(
          noItemsFoundIndicatorBuilder: (_) => Center(
                child: MyText(
                  title: user.isActive? tr("noOrders"):tr("noActive"),
                  size: 12,
                  color: MyColors.primary,
                ),
              ),
          itemBuilder: (context, item, index) =>
              orderItem(orderItemModel: item, context: context)),
    );
  }
}
