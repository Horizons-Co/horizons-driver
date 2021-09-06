import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:background_locator/background_locator.dart';
import 'package:base_structure/driver/repository/DriverRepository.dart';
import 'package:base_structure/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:base_structure/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_structure/general/constants/GlobalState.dart';
import 'package:base_structure/general/models/user_model.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/ModaLs/LoadingDialog.dart';

part 'utils.dart';
