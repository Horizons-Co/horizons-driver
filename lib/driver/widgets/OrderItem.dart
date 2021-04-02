import 'package:base_structure/driver/models/order_item_model.dart';
import 'package:base_structure/driver/screens/orderDetails/OrderDetailsImports.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:flutter/material.dart';

Widget orderItem({OrderItemModel orderItemModel, BuildContext context}) {
  return InkWell(
    onTap: () {
      if (orderItemModel.status.id != 5)
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => OrderDetails(orderItemModel)));
    },
    child: Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: MyText(
              title: orderItemModel.merchant.name,
              color: MyColors.white,
              size: 12,
            ),
            decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
          ),
          Container(
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      title: orderItemModel.no.toString(),
                      color: MyColors.black,
                      size: 14,
                    ),
                    MyText(
                      title:
                          "${orderItemModel.price} ${orderItemModel.currency}",
                      color: MyColors.blackOpacity,
                      size: 14,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      title: orderItemModel.createdAt,
                      color: MyColors.black,
                      size: 14,
                    ),
                    MyText(
                      title: orderItemModel.type.name,
                      color: MyColors.black,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
