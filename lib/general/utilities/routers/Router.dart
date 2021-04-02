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
    AdaptiveRoute(page: Splash, initial: true),
    AdaptiveRoute(page: Login),
    AdaptiveRoute(page: Register, fullscreenDialog: true),
    AdaptiveRoute(page: ForgetPassword),
    AdaptiveRoute(page: ResetPassword),
    AdaptiveRoute(page: ContactUs),
    AdaptiveRoute(page: ActiveAccount),
    AdaptiveRoute(page: Home),
    AdaptiveRoute(page: Profile),
    AdaptiveRoute(page: Language),
  ],
)
class $AppRouter {}
