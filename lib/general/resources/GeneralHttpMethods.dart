import 'package:base_structure/general/models/dots/drop_down_model.dart';
import 'package:base_structure/general/utilities/dio_helper/DioImports.dart';
import 'package:flutter/material.dart';

class GeneralHttpMethods {
  BuildContext context;

  GeneralHttpMethods({@required this.context});

  Future<List<DropDownModel>> getCountries() async {
    final data = await DioHelper(context).getGET("countries");
    if (data != null) {
      return List<DropDownModel>.from(
          data.map((x) => DropDownModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<List<DropDownModel>> getCities() async {
    final data = await DioHelper(context).getGET("cities");
    if (data != null) {
      return List<DropDownModel>.from(
          data.map((x) => DropDownModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<List<DropDownModel>> getCarMArks() async {
    final data = await DioHelper(context).getGET("car-makers");
    if (data != null) {
      return List<DropDownModel>.from(
          data.map((x) => DropDownModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<List<DropDownModel>> getCarModel(String carMark) async {
    final data = await DioHelper(context).getGET("car-makers/$carMark/models");
    if (data != null) {
      return List<DropDownModel>.from(
          data.map((x) => DropDownModel.fromJson(x)));
    } else {
      return [];
    }
  }
}
