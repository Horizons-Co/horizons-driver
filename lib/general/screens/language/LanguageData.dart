part of 'LanguageImports.dart';

class LanguageData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController msg = TextEditingController();
  final GlobalKey<CustomButtonState> btnKey =
      new GlobalKey<CustomButtonState>();

  Future<void> changeLang(BuildContext context, String lang) async {
    if (lang == "ar") {
      Utils.changeLanguage("ar", context);
    } else {
      Utils.changeLanguage("en", context);
    }
    ExtendedNavigator.root.pushAndRemoveUntil(Routes.home, (route) => false);
  }
}
