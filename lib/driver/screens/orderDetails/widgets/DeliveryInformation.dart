part of "OrderWidgetsImports.dart";

class DeliveryInfo extends StatelessWidget {
  final OrderItemModel orderItemModel;

  const DeliveryInfo(this.orderItemModel);

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
            title: tr("deliveryInformation"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: "${tr("phone")}:",
                    size: 12,
                    color: MyColors.grey,
                  ),
                  MyText(
                    title: orderItemModel.client.mobile ?? "",
                    size: 12,
                    color: MyColors.black,
                  ),
                ],
              ),
              InkWell(
                onTap: () =>
                    Utils.callPhone(phone: orderItemModel.client.mobile ?? ""),
                child: Image.asset(
                  Res.whats,
                  width: 32,
                  height: 32,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          infoItemsColor(
              context: context,
              timeValue: orderItemModel.scheduledAt == null
                  ? orderItemModel.type.name
                  : orderItemModel.scheduledAt,
              timeTitle: "${tr("receivingTime")}:",
              addressValue: orderItemModel.pickupPoint.id == 1
                  ? orderItemModel.branch.district.name
                  : orderItemModel.client.district.name,
              addressTitle: "${tr("receivingAddress")}:"),
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
