import 'dart:io';

import 'package:base_structure/general/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_structure/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:base_structure/general/constants/Inputs/DropdownTextField.dart';
import 'package:base_structure/general/constants/Inputs/IconTextFiled.dart';
import 'package:base_structure/general/constants/Inputs/InkWellTextField.dart';
import 'package:base_structure/general/constants/Inputs/LabelTextField.dart';
import 'package:base_structure/general/constants/MyColors.dart';
import 'package:base_structure/general/models/dots/drop_down_model.dart';
import 'package:base_structure/general/resources/GeneralRepository.dart';
import 'package:base_structure/general/screens/register/RegisterImports.dart';
import 'package:base_structure/general/utilities/utils_functions/UtilsImports.dart';
import 'package:base_structure/general/utilities/validator/Validator.dart';
import 'package:base_structure/general/widgets/LoadingButton.dart';
import 'package:base_structure/general/widgets/MyText.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/iterables.dart';

part 'BuildHaveAccount.dart';
part 'BuildRegisterButton.dart';
part 'BuildRegisterInputs.dart';
