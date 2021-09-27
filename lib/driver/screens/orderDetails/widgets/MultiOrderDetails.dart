part of "OrderWidgetsImports.dart";

class MultiOrderDetails extends StatelessWidget {
  final OrderItemModel orderItemModel;
  final OrderDetailsData orderDetailsData;
  const MultiOrderDetails(this.orderItemModel, this.orderDetailsData);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                title: orderItemModel.branch.name,
                size: 12,
                color: MyColors.black,
              ),
              InkWell(
                onTap: () {
                  Utils.openMap(
                      json.encode({
                        "lat": orderItemModel.branch.lat,
                        "lng": orderItemModel.branch.lng,
                      }),
                      context);
                },
                child: Image.asset(
                  Res.location,
                  width: 32,
                  height: 32,
                ),
              )
            ],
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
                    title: orderItemModel.branch.mobile ?? "",
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
                          orderItemModel.branch.mobile.replaceFirst("0", "");
                      final link = WhatsAppUnilink(
                        phoneNumber: "+966$phone",
                        text: "",
                      );
                      await launch('$link');
                      // Utils.launchURL(
                      //     url:
                      //         "https://wa.me/+966$phone?text=معك مندوب شركة آفاق معي لك شحنة من متجر ${orderItemModel.branch.name}");
                    },
                    phone: () {
                      Utils.callPhone(
                          phone: orderItemModel.branch.mobile ?? "");
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
}
