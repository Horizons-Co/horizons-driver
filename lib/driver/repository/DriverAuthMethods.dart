import 'package:base_structure/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/models/user_model.dart';
import 'package:base_structure/general/utilities/dio_helper/DioImports.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverAuthMethods {
  BuildContext context;

  DriverAuthMethods({@required this.context});

  Future<bool> getUserData() async {
    var _data = await DioHelper(context).get("drivers/me", {});
    print("data is $_data");
    if (_data != null) {
      UserModel user = UserModel.fromJson(_data["data"]);
      GlobalState.instance.set("userId", user.id);
      await Utils.saveUserData(user);
      Utils.setCurrentUserData(user, context);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changeNotify(bool active) async {
    final user = context.read<UserCubit>().state.model;
    final response = await DioHelper(context)
        .patch("drivers/${user.id}/status/${active ? 1 : 0}", {});
    if (response != null) {
      UserModel userModel = UserModel(
          name: user.name,
          id: user.id,
          mobile: user.mobile,
          carImage: user.carImage,
          year: user.year,
          city: user.city,
          idImage: user.idImage,
          idNo: user.idNo,
          isOnline: user.isOnline,
          isVerified: active,
          isActive: user.isActive,
          nationality: user.nationality,
          personalImage: user.personalImage,
          suspended: user.suspended);
      await Utils.saveUserData(userModel);
      Utils.setCurrentUserData(userModel, context);
      return true;
    } else {
      return false;
    }
  }
}
