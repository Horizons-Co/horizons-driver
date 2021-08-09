part of "LocationPermissionImports.dart";

class LocationPermissionData {
  final GenericCubit<bool> showReviewCubit = GenericCubit<bool>(false);
  void acceptBackgroundLocation(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final location = new Location();

    bool permission = await Utils.askForPermission(location);
    if (permission) {
      handler.PermissionStatus requestLocation =
      await handler.Permission.locationAlways.request();
      if(requestLocation.isGranted){
        await LocationPermissions().checkPermissionStatus();
        prefs.setBool("acceptBackground", true);
      }else{
        prefs.setBool("acceptBackground", false);

      }

    } else {
      prefs.setBool("acceptBackground", false);
    }
    ExtendedNavigator.of(context).push(Routes.login);
  }
}
