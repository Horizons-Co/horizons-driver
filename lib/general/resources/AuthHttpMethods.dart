import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_structure/general/models/dots/RegisterModel.dart';
import 'package:base_structure/general/models/user_model.dart';
import 'package:base_structure/general/utilities/dio_helper/DioImports.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/CustomOneSignal.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHttpMethods {
  BuildContext context;

  AuthHttpMethods({@required this.context});

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  Future<bool> userLogin(String phone, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _token = "await _firebaseMessaging.getToken()";
    Map<String, dynamic> body = {
      "mobile": "$phone",
      "password": "$pass",
    };
    var _data = await DioHelper(context).get("drivers/login", body);
    if (_data != null) {
      if (_data['data']['is_verified'] == false ||
          _data['data']["user"]['is_verified'] == false) {
        GlobalState.instance.set("token", _data["data"]["access_token"]);
        await Utils.setDeviceId(_data["data"]["access_token"]);
        UserModel user = UserModel.fromJson(_data["data"]["user"]);
        ExtendedNavigator.root.push(Routes.activeAccount,
            arguments: ActiveAccountArguments(
                user: user, token: _data["data"]["access_token"]));
      } else {
        prefs.setString("lang", "ar");
        print("token ${_data["data"]["access_token"]}");
        await Utils.setDeviceId(_data["data"]["access_token"]);
        UserModel user = UserModel.fromJson(_data["data"]["user"]);

        GlobalState.instance.set("userId", user.id);
        GlobalState.instance.set("token", _data["data"]["access_token"]);
        await Utils.saveUserData(user);
        Utils.setCurrentUserData(user, context);
        CustomOneSignal.initPlatformState(user.id, context);
        ExtendedNavigator.root.pushAndRemoveUntil(Routes.home, (route) => false,
            arguments: HomeArguments(index: 0));
      }

      return true;
    } else {
      return false;
    }
  }

  Future<String> uploadFile(File image) async {
    Map<String, dynamic> body = {
      "file": image,
    };
    var _data =
        await DioHelper(context).uploadFile("uploads", body, showLoader: false);
    if (_data != null) {
      return _data["data"]["url"];
    } else {
      return "";
    }
  }

  Future<bool> userRegister(RegisterModel registerModel) async {
    String carLicence, carImage, profileImage;
    if (registerModel.carLicence != null) {
      carLicence = await uploadFile(registerModel.carLicence);
      print("carLicence $carLicence");
    }
    if (registerModel.userImage != null) {
      profileImage = await uploadFile(registerModel.userImage);
      print("profileImage $profileImage");
    }
    if (registerModel.carImage != null) {
      carImage = await uploadFile(registerModel.carImage);
      print("carImage $carImage");
    }

    Map<String, dynamic> body = {
      "name": "${registerModel.userName}",
      "mobile": "${registerModel.userPhone}",
      "password": "${registerModel.userPassword}",
      "city_id": "${registerModel.userCity}",
      "country_id": "${registerModel.userCountry}",
      "id_no": "${registerModel.userIdentity}",
      "car_model_id": registerModel.userCarModel,
      "id_image": carLicence ?? "",
      "car_image": carImage ?? "",
      "personal_image": profileImage ?? "",
    };
    var _data = await DioHelper(context)
        .post("drivers/register", body, showLoader: false);
    if (_data != null) {
      UserModel user = UserModel.fromJson(_data["data"]);
      ExtendedNavigator.root.push(Routes.activeAccount,
          arguments: ActiveAccountArguments(user: user, token: ""));

      return true;
    } else {
      return false;
    }
  }

  Future<bool> switchNotify() async {
    Map<String, dynamic> body = {
      "lang": "${GlobalState.instance.get("lang")}",
      "user_id": "${GlobalState.instance.get("user_id")}",
    };
    var _data = await DioHelper(context).post("Client/SwitchNotify", body);
    if (_data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> forgetPassword(String phone) async {
    Map<String, dynamic> body = {
      "mobile": "$phone",
    };
    var _data = await DioHelper(context).get("drivers/forget-password", body);
    if (_data != null) {
      ExtendedNavigator.root.push(Routes.resetPassword,
          arguments: ResetPasswordArguments(userId: "sss", phone: phone));
      return true;
    } else {
      return null;
    }
  }

  Future<bool> activeAccount(
      {String pinCode, UserModel userModel, String token}) async {
    Map<String, dynamic> body = {
      "pin_code": "$pinCode",
      "mobile": userModel.mobile
    };
    var _data = await DioHelper(context).get(
      "drivers/mobile/verify",
      body,
    );
    if (_data != null) {
      if (_data["data"]["status"]) {
        if (token == "" || token == null) {
          ExtendedNavigator.root
              .pushAndRemoveUntil(Routes.login, (route) => false);
        } else {
          print("user id is ${userModel.id}");
          await Utils.setDeviceId(token);
          GlobalState.instance.set("userId", userModel.id);
          GlobalState.instance.set("token", token);
          await Utils.saveUserData(userModel);
          Utils.setCurrentUserData(userModel, context);
          ExtendedNavigator.root.pushAndRemoveUntil(
              Routes.home, (route) => false,
              arguments: HomeArguments(index: 0));
        }
      } else {
        LoadingDialog.showSimpleToast("wrongActiveCode");
      }

      return true;
    } else {
      return null;
    }
  }

  Future<bool> resetUserPassword(
      String mobile, String code, String pass) async {
    Map<String, dynamic> body = {
      "mobile": "$mobile",
      "pin_code": "$code",
      "password": "$pass",
    };
    var _data =
        await DioHelper(context).get("drivers/forget-password/confirm", body);
    print("data is $_data");
    if (_data != null) {
      if (_data["data"]["status"] == true) {
        ExtendedNavigator.root
            .pushAndRemoveUntil(Routes.login, (route) => false);
      } else {
        LoadingDialog.showToastNotification(tr("wrongPasswordOrActiveCode"));
      }

      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendMessage(String name, String mail, String message) async {
    Map<String, dynamic> body = {
      "lang": "${GlobalState.instance.get("lang")}",
      "name": "$name",
      "email": "$mail",
      "text": "$message",
    };
    var _data = await DioHelper(context).post("Client/Complaint", body);
    if (_data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendDeviceToken(String merchantId, String oneSignalToken) async {
    Map<String, dynamic> body = {"id": oneSignalToken};
    var _data =
        await DioHelper(context).post("drivers/$merchantId/mobile/token", body);
    if (_data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    LoadingDialog.showLoadingDialog();
    Map<String, dynamic> body = {
      "device_token": GlobalState.instance.get("oneSignalUserId")
    };
    final response = await DioHelper(context).post("drivers/logout", body);
    if (response != null) {
      EasyLoading.dismiss().then((value) {
        Utils.clearSavedData();
        Phoenix.rebirth(context);
      });
    }
  }
}
