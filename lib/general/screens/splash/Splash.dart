part of 'SplashImports.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    OneSignal.shared.promptUserForPushNotificationPermission();
    Future.delayed(Duration(seconds: 5), () => Utils.manipulateSplashData(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: MyColors.primary,
      ),
      alignment: Alignment.center,
      child: AnimationContainer(
          index: 0,
          vertical: false,
          duration: Duration(milliseconds: 500),
          distance: MediaQuery.of(context).size.width * 0.5,
          child: Image.asset(Res.logo)),
    );
  }
}
