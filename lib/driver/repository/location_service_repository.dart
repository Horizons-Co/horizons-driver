import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:background_locator/location_dto.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:dio/dio.dart';

class LocationServiceRepository {
  static LocationServiceRepository _instance = LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';
  String userId, token;

  Future<void> init(Map<dynamic, dynamic> params) async {
    userId = params["userID"];
    token = params["token"];
    final location = LocationDto;
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(location);
  }

  Future<void> dispose() async {
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);

  }

  Future<void> callback(LocationDto locationDto) async {
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    try {
      final res = await Dio().post("https://tracking.quick.sa/api/v1/locations",
          data: {
            "drv": userId,
            "lat": locationDto.latitude,
            "lng": locationDto.longitude,
            "bea": locationDto.heading,
            "acc": locationDto.accuracy,
          },
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Secret":
                "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiYW5hcyIsImlhdCI6MTU5NTE4NTQ3OH0.rj0DsI7rS_xoVVX5z-V-qaaLmzB_MJkbfdVcLejh_jlnoSpZRvXqnBBMNJVWqwUU9TYUb1Y-uAIh-KgyUATv3A",
            "Authorization": "Bearer $token",
            "Locale": "ar"
          }));
    } on DioError catch (e) {
      print("my error is ${e.response.data}");
    }
    send?.send(locationDto);
  }
}
