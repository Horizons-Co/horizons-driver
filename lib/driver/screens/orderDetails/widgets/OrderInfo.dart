part of "OrderWidgetsImports.dart";

class OrderInfo extends StatelessWidget {
  final OrderItemModel orderItemModel;
  const OrderInfo(this.orderItemModel);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MyText(
              color: MyColors.black,
              size: 12,
              title: "${tr("orderNumber")} : ",
            ),
            MyText(
              color: MyColors.black,
              title: orderItemModel.no.toString(),
              size: 13,
              fontWeight: FontWeight.w900,
            ),
          ],
        ),
        Row(
          children: [
            MyText(
              color: MyColors.black,
              size: 12,
              title: tr("status"),
            ),
            MyText(
              color: MyColors.black,
              size: 13,
              fontWeight: FontWeight.w900,
              title: orderItemModel.status.name,
            ),
          ],
        ),
        Row(
          children: [
            MyText(
              color: MyColors.black,
              size: 12,
              title: "${tr("payment")} : ",
            ),
            MyText(
              color: MyColors.black,
              size: 13,
              fontWeight: FontWeight.w900,
              title: orderItemModel.feesPaymentMethod.name,
            ),
          ],
        ),
        Row(
          children: [
            MyText(
              color: MyColors.black,
              size: 12,
              title: "${tr("orderType")} : ",
            ),
            MyText(
              color: MyColors.black,
              size: 13,
              fontWeight: FontWeight.w900,
              title: orderItemModel.type.name,
            ),
          ],
        ),
        Visibility(
          visible: orderItemModel.notes != null,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(.3),
              border: Border.all(color: MyColors.primary.withOpacity(.6)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  title: "${tr("note")}: ",
                  size: 13,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                MyText(
                  title: orderItemModel.notes,
                  size: 11,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
