import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/driver/repository/DriverRepository.dart';
import 'package:base_structure/driver/screens/profile/widgets/BuildProfileImports.dart';
import 'package:base_structure/general/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_structure/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_structure/general/constants/CustomButtonAnimation.dart';
import 'package:base_structure/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/models/car_marks.dart';
import 'package:base_structure/general/models/car_model.dart';
import 'package:base_structure/general/models/city.dart';
import 'package:base_structure/general/models/country.dart';
import 'package:base_structure/general/models/dots/RegisterModel.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:base_structure/res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'Profile.dart';
part 'ProfileData.dart';
