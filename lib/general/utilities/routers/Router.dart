import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:base_structure/driver/screens/home/HomeImports.dart';
import 'package:base_structure/driver/screens/profile/ProfileImports.dart';
import 'package:base_structure/general/screens/active_account/ActiveAccountImports.dart';
import 'package:base_structure/general/screens/contact_us/ContactUsImports.dart';
import 'package:base_structure/general/screens/forget_password/ForgetPasswordImports.dart';
import 'package:base_structure/general/screens/language/LanguageImports.dart';
import 'package:base_structure/general/screens/login/LoginImports.dart';
import 'package:base_structure/general/screens/register/RegisterImports.dart';
import 'package:base_structure/general/screens/reset_password/ResetPasswordImports.dart';
import 'package:base_structure/general/screens/splash/SplashImports.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    //general routes
    CustomRoute(page: Splash, initial: true),
    CustomRoute(page: Login, transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(page: Register, fullscreenDialog: true),
    CustomRoute(page: ForgetPassword, transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(page: ResetPassword, transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(page: ContactUs, transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(page: ActiveAccount, transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(page: Home, transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(page: Profile, transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(page: Language, transitionsBuilder: TransitionsBuilders.slideRight),
  ],
)
class $AppRouter {}
