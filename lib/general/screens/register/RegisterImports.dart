import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_structure/general/constants/CustomButtonAnimation.dart';
import 'package:base_structure/general/constants/Inputs/custom_dropDown/CustomDropDown.dart';
import 'package:base_structure/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/models/dots/RegisterModel.dart';
import 'package:base_structure/general/models/dots/drop_down_model.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/screens/register/widgets/RegisterWidgetsImports.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:base_structure/general/widgets/HeaderLogo.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:base_structure/res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'Register.dart';
part 'RegisterData.dart';
