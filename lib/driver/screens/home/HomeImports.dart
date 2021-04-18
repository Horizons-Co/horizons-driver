import 'dart:isolate';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:base_structure/driver/drawer/DrawerImports.dart';
import 'package:base_structure/driver/repository/DriverRepository.dart';
import 'package:base_structure/driver/repository/location_callback_handler.dart';
import 'package:base_structure/driver/repository/location_service_repository.dart';
import 'package:base_structure/driver/screens/home/taps/DeliveredOrders/DeliveredOrdersImports.dart';
import 'package:base_structure/driver/screens/home/taps/ReceivedOrders/ReceivedOrdersImports.dart';
import 'package:base_structure/driver/screens/home/taps/canceledOrders/CanceledOrdersImports.dart';
import 'package:base_structure/driver/screens/home/taps/currentOrders/CurrentOrdersImports.dart';
import 'package:base_structure/driver/screens/home/widgets/HomeWidgetsImports.dart';
import 'package:base_structure/general/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_structure/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/utilities/utils_functions/CustomOneSignal.dart';
import 'package:base_structure/general/utilities/utils_functions/CustomePushNotification.dart';
import 'package:base_structure/general/utilities/utils_functions/playSound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


part 'Home.dart';
part 'HomeData.dart';
