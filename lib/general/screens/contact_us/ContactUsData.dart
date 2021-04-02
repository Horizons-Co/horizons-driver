part of 'ContactUsImports.dart';

class ContactUsData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController msg = TextEditingController();
  final GlobalKey<CustomButtonState> btnKey =
      new GlobalKey<CustomButtonState>();

  Future<void> sendCompliment(BuildContext context) async {
    // if (formKey.currentState.validate()) {
    //   btnKey.currentState.animateForward();
    //   final send = await GeneralRepository(context)
    //       .sendCompliment(message: msg.text, mail: mail.text, name: name.text);
    //   btnKey.currentState.animateReverse();
    //   if (send) {
    //     name.clear();
    //     mail.clear();
    //     msg.clear();
    //   }
    // }
  }
}
