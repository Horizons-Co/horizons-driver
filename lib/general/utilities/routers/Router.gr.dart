// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../driver/screens/home/HomeImports.dart';
import '../../../driver/screens/profile/ProfileImports.dart';
import '../../models/user_model.dart';
import '../../screens/active_account/ActiveAccountImports.dart';
import '../../screens/contact_us/ContactUsImports.dart';
import '../../screens/forget_password/ForgetPasswordImports.dart';
import '../../screens/language/LanguageImports.dart';
import '../../screens/login/LoginImports.dart';
import '../../screens/register/RegisterImports.dart';
import '../../screens/reset_password/ResetPasswordImports.dart';
import '../../screens/splash/SplashImports.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/Login';
  static const String register = '/Register';
  static const String forgetPassword = '/forget-password';
  static const String resetPassword = '/reset-password';
  static const String contactUs = '/contact-us';
  static const String activeAccount = '/active-account';
  static const String home = '/Home';
  static const String profile = '/Profile';
  static const String language = '/Language';
  static const all = <String>{
    splash,
    login,
    register,
    forgetPassword,
    resetPassword,
    contactUs,
    activeAccount,
    home,
    profile,
    language,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splash, page: Splash),
    RouteDef(Routes.login, page: Login),
    RouteDef(Routes.register, page: Register),
    RouteDef(Routes.forgetPassword, page: ForgetPassword),
    RouteDef(Routes.resetPassword, page: ResetPassword),
    RouteDef(Routes.contactUs, page: ContactUs),
    RouteDef(Routes.activeAccount, page: ActiveAccount),
    RouteDef(Routes.home, page: Home),
    RouteDef(Routes.profile, page: Profile),
    RouteDef(Routes.language, page: Language),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    Splash: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => Splash(),
        settings: data,
      );
    },
    Login: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => Login(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    Register: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => Register(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    ForgetPassword: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ForgetPassword(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    ResetPassword: (data) {
      final args = data.getArgs<ResetPasswordArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ResetPassword(
          args.userId,
          args.phone,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    ContactUs: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ContactUs(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    ActiveAccount: (data) {
      final args = data.getArgs<ActiveAccountArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ActiveAccount(
          args.user,
          args.token,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    Home: (data) {
      final args = data.getArgs<HomeArguments>(
        orElse: () => HomeArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            Home(index: args.index),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    Profile: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => Profile(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
    Language: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => Language(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ResetPassword arguments holder class
class ResetPasswordArguments {
  final String userId;
  final String phone;
  ResetPasswordArguments({@required this.userId, @required this.phone});
}

/// ActiveAccount arguments holder class
class ActiveAccountArguments {
  final UserModel user;
  final String token;
  ActiveAccountArguments({@required this.user, @required this.token});
}

/// Home arguments holder class
class HomeArguments {
  final int index;
  HomeArguments({this.index = 0});
}
