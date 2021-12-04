part of 'ActiveAccountImports.dart';

class ActiveAccountData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final TextEditingController code = TextEditingController();
  final TextEditingController token = TextEditingController();
  UserModel userModel;
  final GlobalKey<CustomButtonState> btnKey =
      new GlobalKey<CustomButtonState>();

  Future<void> activeAccount(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState.validate()) {
      btnKey.currentState.animateForward();
      await GeneralRepository(context).activeAccount(
          pinCode: code.text, userModel: userModel, token: token.text);
      btnKey.currentState.animateReverse();
      // ExtendedNavigator.root.pushAndRemoveUntil(newRouteName, (route) => false);
    }
  }
}
