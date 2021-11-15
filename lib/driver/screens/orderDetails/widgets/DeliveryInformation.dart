part of "OrderWidgetsImports.dart";

class DeliveryInfo extends StatelessWidget {
  final OrderItemModel orderItemModel;
  final OrderDetailsData orderDetailsData;

  const DeliveryInfo(this.orderItemModel, this.orderDetailsData);

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
          InkWell(
            onTap: () => Utils.copToClipboard(
                text: orderItemModel.pickupPoint.id == 2
                    ? orderItemModel.merchant.name
                    : orderItemModel.client.name),
            child: MyText(
              title: tr("name"),
              size: 12,
              color: MyColors.grey,
            ),
          ),
          InkWell(
            onTap: () => Utils.copToClipboard(
                text: orderItemModel.pickupPoint.id == 2
                    ? orderItemModel.merchant.name
                    : orderItemModel.client.name),
            child: MyText(
              title: orderItemModel.pickupPoint.id == 2
                  ? orderItemModel.merchant.name
                  : orderItemModel.client.name,
              size: 12,
              color: MyColors.black,
            ),
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
                    title: orderItemModel.pickupPoint.id == 2
                        ? orderItemModel.branch.mobile ?? ""
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
                          orderItemModel.client.mobile.replaceFirst("0", "");
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
                          phone: orderItemModel.client.mobile ?? "");
                    }),
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
              addressValue: orderItemModel.pickupPoint.id == 2
                  ? orderItemModel.branch.district?.name ?? ""
                  : orderItemModel.client.district?.name ?? "",
              onTap: () {
                if (orderItemModel.pickupPoint.id == 2) {
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
      Function onTap,
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
                // MyText(
                //   title: timeTitle,
                //   size: 12,
                //   color: MyColors.grey,
                // ),
                // MyText(
                //   title: timeValue,
                //   size: 12,
                //   color: MyColors.black,
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
