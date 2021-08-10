import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:base_structure/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:shared_preferences/shared_preferences.dart';

part 'LocationPermission.dart';
part 'LocationPermissionData.dart';
