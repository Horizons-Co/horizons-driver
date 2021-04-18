import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'driver/screens/home/HomeImports.dart';
import 'general/blocs/bloc_observer/BlocObserver.dart';
import 'general/screens/splash/SplashImports.dart';
import 'general/utilities/main_data/MainDataImports.dart';
import 'general/utilities/routers/Router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp(EasyLocalization(
    child: Phoenix(child: MyApp()),
    supportedLocales: [Locale('ar', 'EG'), Locale('en', 'US')],
    path: 'assets/langs',
    fallbackLocale: Locale('ar', 'EG'),
    startLocale: Locale('ar', 'EG'),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = new GlobalKey<NavigatorState>();



  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MultiBlocProvider(
      providers: MainData.providers(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: "driver",
        theme: MainData.defaultThem,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorObservers: [BotToastNavigatorObserver()],
        home: Splash(),
        builder: ExtendedNavigator.builder<AppRouter>(
            router: AppRouter(),
            initialRoute: Routes.splash,
            // initialRouteArgs: navigatorKey,
            navigatorKey: navigatorKey,
            builder: (ctx, child) {
              child = FlutterEasyLoading(child: child); //do something
              child = botToastBuilder(context, child);
              return child;
            }),
      ),
    );
  }


}
