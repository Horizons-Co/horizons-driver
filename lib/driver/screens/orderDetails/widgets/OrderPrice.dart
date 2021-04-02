part of "OrderWidgetsImports.dart";

class OrderPrice extends StatelessWidget {
  final OrderItemModel orderItemModel;
  const OrderPrice(this.orderItemModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: MyColors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: tr("paymentInfo"),
            size: 13,
            color: MyColors.grey,
            fontWeight: FontWeight.w900,
          ),
          Divider(
            color: MyColors.grey,
          ),
          MyText(
            title: tr("name"),
            size: 12,
            color: MyColors.grey,
          ),
          MyText(
            title: orderItemModel.client.name,
            size: 12,
            color: MyColors.black,
          ),
          infoItems(
              title: tr("orderPrice"),
              value: "${orderItemModel.price} ${orderItemModel.currency}",
              bold: false),
          infoItems(
              title: tr("delivery"),
              value: "${orderItemModel.deliveryFees}",
              bold: false),
          infoItems(
              title: tr("tax"),
              value: "${orderItemModel.vat.amount}",
              bold: false),
          Divider(
            color: MyColors.grey,
          ),
          infoItems(
              title: tr("total"), value: "${orderItemModel.total}", bold: true),
          Container(
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
                  size: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                MyText(
                  title: "قم بتحصيل المبلغ كامل من العميل",
                  size: 10,
                  color: Colors.red,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget infoItems({String title, String value, bool bold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyText(
          title: "$title :",
          size: 12,
          color: MyColors.grey,
        ),
        MyText(
          title: value,
          size: 14,
          color: Colors.black,
          fontWeight: bold ? FontWeight.bold : FontWeight.w600,
        ),
      ],
    );
  }
}
