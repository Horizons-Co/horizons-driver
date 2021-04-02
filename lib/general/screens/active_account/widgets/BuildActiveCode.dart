part of 'ActiveAccountWidgetsImports.dart';

class BuildActiveCode extends StatelessWidget {
  final ActiveAccountData accountData;

  BuildActiveCode(this.accountData);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: accountData.formKey,
      child: IconTextFiled(
        label: tr("activeCode"),
        controller: accountData.code,
        validate: (value) => value.validateEmpty(),
        // submit: (val)=> accountData.activeAccount(context),
      ),
    );
  }
}
