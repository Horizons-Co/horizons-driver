part of 'ForgetPasswordWidgetsImports.dart';

class BuildForgetPassInput extends StatelessWidget {
  final ForgetPasswordData forgetPasswordData;
  BuildForgetPassInput(this.forgetPasswordData);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: forgetPasswordData.formKey,
      child: IconTextFiled(
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MyText(
            title: "+966",
          ),
        ),
        label: "55xxxxxxxxx",
        maxLength: 8,
        controller: forgetPasswordData.phone,
        type: TextInputType.phone,
        validate: (value) => value.validatePhone(),
        submit: (val) => forgetPasswordData.sendCode(context),
      ),
    );
  }
}
