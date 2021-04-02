import 'package:auto_route/auto_route.dart';
import 'package:base_structure/driver/models/order_item_model.dart';
import 'package:base_structure/general/utilities/dio_helper/DioImports.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:flutter/material.dart';

class OrdersHttpMethods {
  final BuildContext context;

  OrdersHttpMethods({@required this.context});

  Future<List<OrderItemModel>> getCurrentOrders(int currentPage) async {
    final response =
        await DioHelper(context).getGET("orders?status=3&page=$currentPage");
    if (response != null) {
      return List<OrderItemModel>.from(
          response["data"].map((x) => OrderItemModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<List<OrderItemModel>> getCanceledOrders(int currentPage) async {
    final response =
        await DioHelper(context).getGET("orders?status=21&page=$currentPage");
    if (response != null) {
      return List<OrderItemModel>.from(
          response["data"].map((x) => OrderItemModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<List<OrderItemModel>> getReceivedOrders(int currentPage) async {
    final response =
        await DioHelper(context).getGET("orders?status=4&page=$currentPage");
    if (response != null) {
      print("response ${response["data"]}");
      return List<OrderItemModel>.from(
          response["data"].map((x) => OrderItemModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<List<OrderItemModel>> getDeliveredOrders(int currentPage) async {
    final response =
        await DioHelper(context).getGET("orders?status=5&page=$currentPage");
    if (response != null) {
      return List<OrderItemModel>.from(
          response["data"].map((x) => OrderItemModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<bool> changeOrderStatus({String orderId, String action}) async {
    final response =
        await DioHelper(context).patch("orders/$orderId/actions/$action", {});
    if (response != null) {
      ExtendedNavigator.root.pushAndRemoveUntil(Routes.home, (route) => false);
      return true;
    } else {
      return false;
    }
  }

  Future<void> trackingOrder() async {
    final location = await Utils.getCurrentLocation();

    final body = {
      "drv": "6d9cf8a8-a6e0-4f95-9127-3dc64e1c84ff",
      "lat": location.latitude,
      "lng": location.longitude,
      "bea": location.heading,
      "acc": location.accuracy,
    };
    await DioHelper(context).getGET(
      "locations",
    );
  }
}
