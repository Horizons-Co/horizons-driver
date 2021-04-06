part of 'LoginImports.dart';

class LoginData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final GenericCubit<bool> showPassCubit = GenericCubit<bool>(false);
  final GlobalKey<CustomButtonState> btnKey =
      new GlobalKey<CustomButtonState>();

  Future<void> login(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState.validate()) {
      if (!phone.text.startsWith("5")) {
        return LoadingDialog.showSimpleToast(tr("phoneStartWith05"));
      }else if (phone.text.startsWith("0")) {
        return LoadingDialog.showSimpleToast(tr("phoneValidation"));
      }
      btnKey.currentState.animateForward();
      await GeneralRepository(context)
          .setUserLogin(phone: "0${phone.text}", pass: password.text);
      btnKey.currentState.animateReverse();
    }
  }
}
