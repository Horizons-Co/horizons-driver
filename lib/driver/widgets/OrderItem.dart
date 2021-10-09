import 'dart:convert';

import 'package:base_structure/driver/models/order_item_model.dart';
import 'package:base_structure/driver/screens/orderDetails/OrderDetailsImports.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/utilities/utils_functions/playSound.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget orderItem(
    {OrderItemModel orderItemModel, BuildContext context, Function pending}) {
  print("order is ${json.encode(orderItemModel)}");
  return Visibility(
    visible: orderItemModel.status.id == 6,
    child: InkWell(
      onTap: pending,
      // onTap: () {
      //   print("now ${DateFormat("HH:mm", "en").format(DateTime.now())}");
      //   print(
      //       "order ${DateFormat("HH:mm", "en").format(DateTime.parse(orderItemModel.assignedAt).subtract(Duration(hours: 1)))}");
      //   print(
      //       "asdasd ${DateTime.now().difference(DateTime.parse(orderItemModel.assignedAt).subtract(Duration(hours: 1))).inSeconds}");
      // },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: MyText(
                title: orderItemModel.merchant?.name ?? "",
                color: MyColors.white,
                size: 12,
              ),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
            ),
            Container(
              height: 90,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: orderItemModel.no.toString(),
                        color: MyColors.white,
                        size: 14,
                      ),
                      MyText(
                        title: orderItemModel.createdAt,
                        color: MyColors.white,
                        size: 14,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: MyText(
                      title: tr("new"),
                      color: MyColors.white,
                      size: 14,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: Colors.white)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        title: "${orderItemModel.total}",
                        color: MyColors.white,
                        size: 14,
                      ),
                      MyText(
                        title: orderItemModel.isMultiple
                            ? tr("multipleOrder")
                            : orderItemModel.type.name,
                        color: MyColors.white,
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
    ),
    replacement: InkWell(
      onTap: () {
        if ((orderItemModel.id == GlobalState.instance.get("currentOrderId")) &&
            (orderItemModel.status.id != 3)) {
          PlayNotificationSound.stopSound();
        } else if (orderItemModel.status.id != 5 &&
            orderItemModel.status.id != 21)
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
                title: orderItemModel.merchant?.name ?? "",
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
                        title: "${orderItemModel.total}",
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
                        title: orderItemModel.isMultiple
                            ? tr("multipleOrder")
                            : orderItemModel.type.name,
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
    ),
  );
}
