part of 'ResetPassWidgetImports.dart';

class BuildResetPassInputs extends StatelessWidget {
  final ResetPasswordData resetPasswordData;
  BuildResetPassInputs(this.resetPasswordData);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: resetPasswordData.formKey,
      child: Column(
        children: [
          IconTextFiled(
            label: tr("activeCode"),
            controller: resetPasswordData.code,
            type: TextInputType.phone,
            action: TextInputAction.next,
            margin: const EdgeInsets.symmetric(vertical: 8),
            validate: (value) => value.validateEmpty(),
          ),
          IconTextFiled(
            label: tr("writeNewPassword"),
            controller: resetPasswordData.password,
            action: TextInputAction.next,
            margin: const EdgeInsets.symmetric(vertical: 8),
            validate: (value) => value.validatePassword(),
            isPassword: true,
          )
        ],
      ),
    );
  }
}
