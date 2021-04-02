part of 'ForgetPasswordWidgetsImports.dart';

class BuildForgetPassButton extends StatelessWidget {
  final ForgetPasswordData forgetPasswordData;
  BuildForgetPassButton(this.forgetPasswordData);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: LoadingButton(
        btnKey: forgetPasswordData.btnKey,
        title: tr("send"),
        borderRadius: 5,
        margin: const EdgeInsets.all(20),
        color: Colors.red,
        onTap: () => forgetPasswordData.sendCode(context),
      ),
    );
  }
}
