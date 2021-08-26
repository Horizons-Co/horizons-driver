part of "OrderWidgetsImports.dart";

class MultiOrderDetails extends StatelessWidget {
  final OrderItemModel orderItemModel;

  const MultiOrderDetails(this.orderItemModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: MyColors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoItems(context),
        ],
      ),
    );
  }

  Widget infoItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: tr("receiveInfo"),
            size: 13,
            color: MyColors.grey,
            fontWeight: FontWeight.w900,
          ),
          Divider(
            color: MyColors.grey,
          ),
          MyText(
            title: "${tr("shopBranch")}:",
            size: 12,
            color: MyColors.grey,
          ),
          MyText(
            title: orderItemModel.branch.name,
            size: 12,
            color: MyColors.black,
          ),
          MyText(
            title: "${tr("ordersCount")}:",
            size: 12,
            color: MyColors.grey,
          ),
          MyText(
            title: orderItemModel.quantity.toString(),
            size: 12,
            color: MyColors.black,
          ),
        ],
      ),
    );
  }
}
