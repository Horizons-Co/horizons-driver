part of 'ResetPasswordImports.dart';

class ResetPasswordData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<CustomButtonState> btnKey =
      new GlobalKey<CustomButtonState>();
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  final GenericCubit<bool> showPassCubit = GenericCubit<bool>(false);
  final GenericCubit<bool> showConfirmPassCubit = GenericCubit<bool>(false);

  Future<void> resetPassword(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState.validate()) {
      btnKey.currentState.animateForward();
      await GeneralRepository(context).resetUserPassword(
          pass: password.text, code: code.text, mobile: phone.text);
      btnKey.currentState.animateReverse();
    }
  }
}
