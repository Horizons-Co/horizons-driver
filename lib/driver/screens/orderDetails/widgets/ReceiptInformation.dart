part of "OrderWidgetsImports.dart";

class ReceiptInfo extends StatelessWidget {
  final OrderItemModel orderItemModel;
  const ReceiptInfo(this.orderItemModel);
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
          infoItems(),
          infoItemsColor(
              context: context,
              timeValue: orderItemModel.type.id == 1
                  ? orderItemModel.type.name
                  : "${orderItemModel.logs[0].date} ${orderItemModel.logs[0].time.substring(0, orderItemModel.logs[0].time.length - 3)}",
              timeTitle: "${tr("receiveTime")}:",
              addressValue: orderItemModel.pickupPoint.id == 2
                  ? orderItemModel.branch.district.name
                  : orderItemModel.client.district.name,
              addressTitle: "${tr("receiveAddress")}:"),
        ],
      ),
    );
  }

  Widget infoItems() {
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
            title: "${tr("shopOrClientName")}:",
            size: 12,
            color: MyColors.grey,
          ),
          MyText(
            title: orderItemModel.branch.name,
            size: 12,
            color: MyColors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: "${tr("phone")}",
                    size: 12,
                    color: MyColors.grey,
                  ),
                  MyText(
                    title: orderItemModel.merchant.mobile ?? "",
                    size: 12,
                    color: MyColors.black,
                  ),
                ],
              ),
              InkWell(
                onTap: () => Utils.callPhone(
                    phone: orderItemModel.merchant.mobile ?? ""),
                child: Image.asset(
                  Res.whats,
                  width: 32,
                  height: 32,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget infoItemsColor(
      {BuildContext context,
      String addressTitle,
      String addressValue,
      String timeTitle,
      String timeValue}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyColors.greyWhite.withOpacity(.12),
              border: Border.all(color: MyColors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: addressTitle,
                          size: 12,
                          color: MyColors.grey,
                        ),
                        MyText(
                          title: addressValue,
                          size: 12,
                          color: MyColors.black,
                        ),
                      ],
                    ),
                    Image.asset(
                      Res.location,
                      width: 32,
                      height: 32,
                    )
                  ],
                ),
                MyText(
                  title: timeTitle,
                  size: 12,
                  color: MyColors.grey,
                ),
                MyText(
                  title: timeValue,
                  size: 12,
                  color: MyColors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
