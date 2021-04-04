// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

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
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => Splash(),
        settings: data,
      );
    },
    Login: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => Login(),
        settings: data,
      );
    },
    Register: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => Register(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    ForgetPassword: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ForgetPassword(),
        settings: data,
      );
    },
    ResetPassword: (data) {
      final args = data.getArgs<ResetPasswordArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ResetPassword(
          args.userId,
          args.phone,
        ),
        settings: data,
      );
    },
    ContactUs: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ContactUs(),
        settings: data,
      );
    },
    ActiveAccount: (data) {
      final args = data.getArgs<ActiveAccountArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => ActiveAccount(
          args.user,
          args.token,
        ),
        settings: data,
      );
    },
    Home: (data) {
      final args = data.getArgs<HomeArguments>(
        orElse: () => HomeArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => Home(index: args.index),
        settings: data,
      );
    },
    Profile: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => Profile(),
        settings: data,
      );
    },
    Language: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => Language(),
        settings: data,
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
