part of 'UtilsImports.dart';

class Utils {
  static Future<void> manipulateSplashData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var strUser = prefs.get("user");
    var lang = prefs.get("lang");
    String token = prefs.getString("deviceId");
    final String oneSignalUserId = prefs.getString("oneSignalUserId");
    GlobalState.instance.set("oneSignalUserId", oneSignalUserId);

    if (strUser != null) {
      GlobalState.instance.set("token", token);
      bool logged = await DriverRepository(context).getUserData();
      if (logged) {
        // UserModel data = UserModel.fromJson(json.decode(strUser));
        GlobalState.instance.set("token", token);
        // GlobalState.instance.set("userId", data.id);
        changeLanguage(lang ?? "ar", context);
        // setCurrentUserData(data, context);
        ExtendedNavigator.of(context).pushAndRemoveUntil(
            Routes.home, (route) => false,
            arguments: HomeArguments(index: 0));
      } else {
        BackgroundLocator.unRegisterLocationUpdate();
        clearSavedData();

        changeLanguage("ar", context);
        ExtendedNavigator.of(context)
            .pushAndRemoveUntil(Routes.login, (route) => false);
      }
    } else {
      changeLanguage("ar", context);
      ExtendedNavigator.of(context)
          .pushAndRemoveUntil(Routes.login, (route) => false);
    }
  }

  static void setCurrentUserData(UserModel model, BuildContext context) async {
    context.read<UserCubit>().onUpdateUserData(model);
    // if (model.type == "user") {
    //   ExtendedNavigator.of(context).push(
    //     Routes.customerHome,
    //   );
    // } else {
    //   ExtendedNavigator.of(context).push(
    //     Routes.companyHome,
    //   );
    // }
  }

  static Future<void> saveUserData(UserModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(model.toJson()));
  }

  static Future<void> changeLanguage(String lang, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    context.read<LangCubit>().onChangeLanguage(lang);
    var userCubit = context.read<UserCubit>();
    // userCubit.state.model.lang = lang;
    userCubit.onUpdateUserData(userCubit.state.model);
    if (lang == "en") {
      context.locale = Locale('en', 'US');
      prefs.setString("lang", "en");
    } else {
      context.locale = Locale('ar', 'EG');
      prefs.setString("lang", "ar");
    }
  }

  // static UserModel getSavedUser({@required BuildContext context}) {
  //   return context.read<UserCubit>().state.model;
  // }

  static Future<String> getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("deviceId");
  }

  static Future<void> setDeviceId(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("deviceId", token);
  }

  static void clearSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalState.instance.set("token", "");
    prefs.clear();
  }

  // static CustomerModel getCustomerData({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.customer;
  // }

  // static DelegateModel getDelegateData({@required BuildContext context}){
  //   var provider = Provider.of<UserProvider>(context,listen: false);
  //   return provider.model.delegate;
  // }

  // static int getCurrentUserType({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.type;
  // }
  //
  // static String getCurrentUserLang({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.lang;
  // }
  //
  // static String getCurrentUserToken({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.token;
  // }
  //
  // static void setCurrentUserType({@required BuildContext context,@required int type}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   SavedDataModel model=provider.model;
  //   model.type=type;
  //   provider.setUserModel(model);
  // }

  // static void setCurrentUserLang({@required BuildContext context,@required String lang}){
  //   var provider =Provider.of<UserStore>(context,listen: false);
  //   SavedDataModel model=provider.model;
  //   model.lang=lang;
  //   provider.setUserModel(model);
  //   saveUserData(provider.model);
  //   changeLanguage(lang,context);
  // }

  // static String getCurrentUserId({@required BuildContext context}) {
  //   var provider = context.watch<UserCubit>().state.model;
  //   return provider.id;
  // }

  // static void setSelectUser({@required int type, @required BuildContext context}) async {
  //   setCurrentUserType(context: context,type: type);
  //   ExtendedNavigator(router: AppRouter(), name: Routes.login);
  // }

  static void launchURL({String url}) async {
    if (!url.toString().startsWith("https")) {
      url = "https://" + url;
    }
    await launch(url);
  }

  static void launchWhatsApp(phone) async {
    String message = 'مرحبا بك';
    if (phone.startsWith("00966")) {
      phone = phone.substring(5);
    }
    var _whatsAppUrl = "whatsapp://send?phone=+966$phone&text=$message";
    print(_whatsAppUrl);
    if (await canLaunch(_whatsAppUrl)) {
      await launch(_whatsAppUrl);
    } else {
      throw 'حدث خطأ ما';
    }
  }

  static void launchYoutube({@required String url}) async {
    if (Platform.isIOS) {
      if (await canLaunch('$url')) {
        await launch('$url', forceSafariVC: false);
      } else {
        if (await canLaunch('$url')) {
          await launch('$url');
        } else {
          throw 'Could not launch $url';
        }
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static void callPhone({phone}) async {
    await launch("tel:$phone");
  }

  static void sendMail(mail) async {
    await launch("mailto:$mail");
  }

  static void shareApp(url) {
    LoadingDialog.showLoadingDialog();
    Share.share(url).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  static Future<File> getImage({ImageSource imageSource}) async {
    PickedFile image = await ImagePicker()
        .getImage(source: imageSource ?? ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  static Future<List<File>> getImages() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File> getImageFile() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image,allowCompression: true,);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      return files.first;
    } else {
      return null;
    }
  }

  static Future<File> getVideo() async {
    PickedFile image =
        await ImagePicker().getVideo(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  static void copToClipboard({String text, GlobalKey<ScaffoldState> scaffold}) {
    if (text.trim().isEmpty) {
      LoadingDialog.showToastNotification(tr("couponValidation"));
      return;
    } else {
      Clipboard.setData(ClipboardData(text: "$text")).then((value) {
        LoadingDialog.showToastNotification(tr("couponSuccess"));
      });
    }
  }

  static Future<bool> askForPermission(Location location) async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.DENIED_FOREVER) {
      return false;
    } else if (permission == PermissionStatus.DENIED) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.DENIED ||
          permission == PermissionStatus.DENIED_FOREVER) {
        return false;
      }
    }
    return true;
  }

  static Future<LocationData> getCurrentLocation() async {
    final location = new Location();
    bool permission = await askForPermission(location);
    LocationData current;
    if (permission) {
      current = await location.getLocation();
    }
    return current;
  }

  static void openMap(String location) async {
    Map<String, dynamic> address = json.decode(location);
    String url;
    String urlAppleMaps;
    if (Platform.isAndroid) {
      url =
          "https://www.google.com/maps/search/?api=1&query=${address["lat"].toString()},${address["lng"].toString()}";
      print("url is $url");
      if (await canLaunch(url)) {
        print("sss");
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      urlAppleMaps =
          'https://maps.apple.com/?q=${address["lat"].toString()},${address["lng"].toString()}';
      if (await canLaunch(urlAppleMaps)) {
        await launch(urlAppleMaps);
      } else {
        throw 'Could not launch $urlAppleMaps';
      }
    }
  }

  static String convertDigitsToLatin(String s) {
    var sb = new StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
        //Arabic digits
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }
}
