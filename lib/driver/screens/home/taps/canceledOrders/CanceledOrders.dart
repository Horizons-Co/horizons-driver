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
    var user = context.watch<UserCubit>().state.model;
    return PagedListView<int, OrderItemModel>(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(vertical: 10),
      pagingController: canceledOrdersData.pagingController,
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
