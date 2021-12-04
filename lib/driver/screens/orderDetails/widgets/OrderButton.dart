part of "OrderWidgetsImports.dart";

class OrderButton extends StatelessWidget {
  final OrderDetailsData orderDetailsData;
  final OrderItemModel orderItemModel;
  const OrderButton(this.orderDetailsData, this.orderItemModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: MyColors.black,
        border: Border.all(color: MyColors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return _buildStepperItem(
                    index: index,
                    place: index == 0
                        ? orderItemModel.pickupPoint.id == 1
                            ? orderItemModel.branch?.district?.name ?? ""
                            : orderItemModel.client?.district?.name ?? ""
                        : orderItemModel.isMultiple
                            ? tr("store")
                            : orderItemModel.pickupPoint.id == 2
                                ? orderItemModel.branch?.district?.name ?? ""
                                : orderItemModel.client?.district?.name ?? "",
                    title: index == 0 ? tr("receiveFrom") : tr("deliverTo"),
                    image: index == 0 ? Res.place : Res.location);
              },
            ),
          ),
          Visibility(
            visible: orderItemModel.status.id < 5,
            child: DefaultButton(
              title: orderItemModel.status.id == 3
                  ? tr("received")
                  : tr("delivered"),
              color: orderItemModel.status.id == 3 ? Colors.blue : Colors.green,
              textColor: MyColors.white,
              onTap: () => orderDetailsData.showOrderAlert(
                  title: orderItemModel.status.id == 3
                      ? tr("hasBeenReceived")
                      : tr("hasBeenDelivered"),
                  context: context,
                  acceptTitle: orderItemModel.status.id == 3
                      ? tr("confirmReceive")
                      : tr("confirmDeliver"),
                  onAccept: () {
                    DriverRepository(context).changeOrderStatus(
                        orderId: orderItemModel.id,
                        action: orderItemModel.status.id == 3 ? "1" : "2");
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStepperItem(
      {int index, String image, String title, String place}) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(image))),
                ),
                Visibility(
                  visible: 2 != (index + 1),
                  child: Expanded(
                    child: VerticalDivider(
                      color: Colors.blue,
                      thickness: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: title,
                      size: 12,
                      color: MyColors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    MyText(
                      title: place,
                      size: 10,
                      color: MyColors.white,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
