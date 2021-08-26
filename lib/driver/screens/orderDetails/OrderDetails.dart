part of 'OrderDetailsImports.dart';

class OrderDetails extends StatelessWidget {
  final OrderItemModel orderItemModel;
  OrderDetails(this.orderItemModel);
  final OrderDetailsData _orderDetailsData = OrderDetailsData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: ImageIcon(
            AssetImage(Res.removeBlack),
            size: 40,
          ),
          onPressed: () => ExtendedNavigator.root.pop(),
        ),
      ),
      body: Container(
        color: MyColors.grey.withOpacity(.1),
        child: ListView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Visibility(
              visible: orderItemModel.isMultiple == false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderInfo(orderItemModel),
                  // AnimationContainer(
                  //     duration: Duration(seconds: 1),
                  //     vertical: false,
                  //     distance: 200,
                  //     index: 1,
                  //     child: OrderStatus(orderItemModel)),
                  ReceiptInfo(orderItemModel, _orderDetailsData),
                  DeliveryInfo(orderItemModel, _orderDetailsData),
                  OrderPrice(orderItemModel),
                ],
              ),
              replacement: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderInfo(orderItemModel),
                  MultiOrderDetails(orderItemModel),
                ],
              ),
            ),
            OrderButton(_orderDetailsData, orderItemModel)
          ],
        ),
      ),
    );
  }
}
