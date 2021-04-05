part of 'OrderDetailsImports.dart';

class OrderDetails extends StatelessWidget {
  final OrderItemModel orderItemModel;
  OrderDetails(this.orderItemModel);
  final OrderDetailsData _orderDetailsData = OrderDetailsData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey.withOpacity(.1),
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
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          AnimationContainer(
              duration: Duration(seconds: 1),
              vertical: false,
              distance: 200,
              index: 0,
              child: OrderInfo(orderItemModel)),
          // AnimationContainer(
          //     duration: Duration(seconds: 1),
          //     vertical: false,
          //     distance: 200,
          //     index: 1,
          //     child: OrderStatus(orderItemModel)),
          AnimationContainer(
              duration: Duration(seconds: 1),
              vertical: false,
              distance: 200,
              index: 2,
              child: ReceiptInfo(orderItemModel, _orderDetailsData)),
          AnimationContainer(
              duration: Duration(seconds: 1),
              vertical: false,
              distance: 200,
              index: 3,
              child: DeliveryInfo(orderItemModel, _orderDetailsData)),
          AnimationContainer(
              duration: Duration(seconds: 1),
              vertical: false,
              distance: 200,
              index: 4,
              child: OrderPrice(orderItemModel)),
          AnimationContainer(
              duration: Duration(seconds: 1),
              vertical: false,
              distance: 200,
              index: 5,
              child: OrderButton(_orderDetailsData, orderItemModel))
        ],
      ),
    );
  }
}
