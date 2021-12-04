import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_structure/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:base_structure/general/utilities/routers/Router.gr.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constants/GlobalState.dart';
import '../../constants/ModaLs/LoadingDialog.dart';
import '../utils_functions/UtilsImports.dart';

part 'DioHelper.dart';
