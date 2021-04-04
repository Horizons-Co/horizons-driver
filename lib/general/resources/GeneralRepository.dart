import 'package:base_structure/general/models/dots/RegisterModel.dart';
import 'package:base_structure/general/models/dots/drop_down_model.dart';
import 'package:base_structure/general/models/user_model.dart';
import 'package:base_structure/general/resources/GeneralHttpMethods.dart';
import 'package:flutter/material.dart';

import 'AuthHttpMethods.dart';

class GeneralRepository {
  BuildContext _context;
  AuthHttpMethods _authHttpMethods;
  GeneralHttpMethods _generalHttpMethods;

  GeneralRepository(BuildContext context) {
    _context = context;
    _authHttpMethods = new AuthHttpMethods(context: _context);
    _generalHttpMethods = GeneralHttpMethods(context: _context);
  }

  Future<bool> setUserLogin({String phone, String pass}) =>
      _authHttpMethods.userLogin(phone, pass);

  Future<bool> userRegister(RegisterModel registerModel) async =>
      _authHttpMethods.userRegister(registerModel);

  Future<bool> activeAccount(
          {String pinCode, UserModel userModel, String token}) async =>
      _authHttpMethods.activeAccount(
          token: token, pinCode: pinCode, userModel: userModel);

  Future<bool> forgetPassword(String phone) =>
      _authHttpMethods.forgetPassword(phone);

  Future<bool> resetUserPassword(
          {String mobile, String code, String pass}) async =>
      _authHttpMethods.resetUserPassword(mobile, code, pass);

  Future<void> logout() => _authHttpMethods.logout();

//  general
  Future<List<DropDownModel>> getCountries() async =>
      _generalHttpMethods.getCountries();

  Future<List<DropDownModel>> getCities() async =>
      _generalHttpMethods.getCities();

  Future<List<DropDownModel>> getCarMArks() async =>
      _generalHttpMethods.getCarMArks();

  Future<List<DropDownModel>> getCarModel(String carMark) async =>
      _generalHttpMethods.getCarModel(carMark);

  Future<bool> sendDeviceToken({String merchantId, String oneSignalToken})=>
      _authHttpMethods.sendDeviceToken(merchantId, oneSignalToken);

}
