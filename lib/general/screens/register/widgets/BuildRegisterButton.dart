part of 'RegisterWidgetsImports.dart';

class BuildRegisterButton extends StatelessWidget {
  final RegisterData registerData;
  BuildRegisterButton(this.registerData);
  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      btnKey: registerData.btnKey,
      title: tr("register"),
      onTap: () => registerData.register(context),
      borderRadius: 10,
      color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }
}
