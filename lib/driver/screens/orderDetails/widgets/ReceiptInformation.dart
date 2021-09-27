part of "OrderWidgetsImports.dart";

class ReceiptInfo extends StatelessWidget {
  final OrderItemModel orderItemModel;
  final OrderDetailsData orderDetailsData;
  const ReceiptInfo(this.orderItemModel, this.orderDetailsData);
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
          infoItemsColor(
              context: context,
              timeValue: orderItemModel.scheduledAt == null
                  ? orderItemModel.type.name
                  : orderItemModel.scheduledAt,
              timeTitle: "${tr("receiveTime")}:",
              addressValue: orderItemModel.pickupPoint.id == 1
                  ? orderItemModel.branch.district?.name ?? ""
                  : orderItemModel.client.district?.name ?? "",
              onTap: () {
                if (orderItemModel.pickupPoint.id == 1) {
                  Utils.openMap(
                      json.encode({
                        "lat": orderItemModel.branch.lat,
                        "lng": orderItemModel.branch.lng,
                      }),
                      context);
                } else {
                  Utils.openMap(
                      json.encode({
                        "lat": orderItemModel.client.lat,
                        "lng": orderItemModel.client.lag,
                      }),
                      context);
                }
              },
              addressTitle: "${tr("receiveAddress")}:"),
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
            title: "${tr("shopOrClientName")}:",
            size: 12,
            color: MyColors.grey,
          ),
          MyText(
            title: orderItemModel.pickupPoint.id == 1
                ? orderItemModel.branch.name
                : orderItemModel.client.name,
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
                    title: orderItemModel.pickupPoint.id == 1
                        ? orderItemModel.merchant.mobile ?? ""
                        : orderItemModel.client.mobile ?? "",
                    size: 12,
                    color: MyColors.black,
                  ),
                ],
              ),
              InkWell(
                onTap: () => orderDetailsData.callWhatsAppOrPhone(
                    context: context,
                    whatsApp: () async {
                      String phone =
                          orderItemModel.merchant.mobile.replaceFirst("0", "");
                      final link = WhatsAppUnilink(
                        phoneNumber: "+966$phone",
                        text: "",
                      );
                      await launch('$link');
                      // Utils.launchURL(
                      //     url:
                      //         "https://wa.me/+966$phone?text=معك مندوب شركة آفاق معي لك شحنة من متجر ${orderItemModel.merchant.name}");
                    },
                    phone: () {
                      Utils.callPhone(
                          phone: orderItemModel.merchant.mobile ?? "");
                    }),
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
      Function onTap,
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
                    InkWell(
                      onTap: onTap,
                      child: Image.asset(
                        Res.location,
                        width: 32,
                        height: 32,
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: orderItemModel.type.id == 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
          )
        ],
      ),
    );
  }
}
