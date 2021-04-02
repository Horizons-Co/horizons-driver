part of "OrderWidgetsImports.dart";

class OrderStatus extends StatelessWidget {
  final OrderItemModel orderItemModel;
  const OrderStatus(this.orderItemModel);
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
            title: tr("status"),
            size: 13,
            color: MyColors.grey,
            fontWeight: FontWeight.w900,
          ),
          Divider(
            color: MyColors.grey,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            height: (orderItemModel.timeline.length * 75).toDouble(),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderItemModel.timeline.length,
              itemBuilder: (context, index) {
                return _buildStepperItem(
                    index: index,
                    timeline: orderItemModel.timeline[index],
                    length: orderItemModel.timeline.length);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStepperItem({int index, Timeline timeline, int length}) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Container(
                  height: 13,
                  width: 13,
                  decoration:
                      BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                ),
                Visibility(
                  visible: length != (index + 1),
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: timeline.event,
                      size: 12,
                      color: MyColors.black,
                      fontWeight: FontWeight.w900,
                    ),
                    MyText(
                      title: timeline.createdBy,
                      size: 10,
                      color: MyColors.blackOpacity,
                    ),
                    MyText(
                      title: timeline.createdAt,
                      size: 10,
                      color: MyColors.blackOpacity,
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
