part of 'ForgetPasswordImports.dart';

class ForgetPasswordData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<CustomButtonState> btnKey =
      new GlobalKey<CustomButtonState>();
  TextEditingController phone = TextEditingController();

  Future<void> sendCode(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState.validate()) {
      if (!phone.text.startsWith("5")) {
        return LoadingDialog.showSimpleToast(tr("phoneStartWith05"));
      }
      btnKey.currentState.animateForward();
      await GeneralRepository(context).forgetPassword("0${phone.text}");
      btnKey.currentState.animateReverse();
    }
  }
}
