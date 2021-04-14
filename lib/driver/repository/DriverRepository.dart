import 'package:base_structure/driver/models/order_item_model.dart';
import 'package:base_structure/driver/repository/DriverAuthMethods.dart';
import 'package:base_structure/driver/repository/OrderHttpMethods.dart';
import 'package:flutter/material.dart';

class DriverRepository {
  BuildContext _context;
  OrdersHttpMethods _orderHttpMethods;
  DriverAuthMethods _driverAuthMethods;

  DriverRepository(BuildContext context) {
    _context = context;
    _orderHttpMethods = new OrdersHttpMethods(context: _context);
    _driverAuthMethods = DriverAuthMethods(context: _context);
  }

  Future<List<OrderItemModel>> getNewOrders() async =>
      _orderHttpMethods.getNewOrders();
  Future<List<OrderItemModel>> getCurrentOrders(int currentPage) async =>
      _orderHttpMethods.getCurrentOrders(currentPage);
  Future<List<OrderItemModel>> getCanceledOrders(int currentPage) async =>
      _orderHttpMethods.getCanceledOrders(currentPage);
  Future<List<OrderItemModel>> getReceivedOrders(int currentPage) async =>
      _orderHttpMethods.getReceivedOrders(currentPage);
  Future<List<OrderItemModel>> getDeliveredOrders(int currentPage) async =>
      _orderHttpMethods.getDeliveredOrders(currentPage);
  Future<bool> changeOrderStatus({String orderId, String action}) async =>
      _orderHttpMethods.changeOrderStatus(orderId: orderId, action: action);
  Future<bool> changeOrderStatusFromNotify({String orderId, String action}) async =>
      _orderHttpMethods.changeOrderStatusFromNotify(orderId: orderId, action: action);

//  auth

  Future<bool> getUserData() async => _driverAuthMethods.getUserData();
  Future<bool> changeNotify(bool active) async =>
      _driverAuthMethods.changeNotify(active);

//  tracking
  Future<void> trackingOrder() async => _orderHttpMethods.trackingOrder();
}
