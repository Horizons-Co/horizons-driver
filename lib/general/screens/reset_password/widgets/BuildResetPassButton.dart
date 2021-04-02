part of 'ResetPassWidgetImports.dart';

class BuildResetPassButton extends StatelessWidget {
  final ResetPasswordData resetPasswordData;
  BuildResetPassButton(this.resetPasswordData);
  @override
  Widget build(BuildContext context) {
    return LoadingButton(
        btnKey: resetPasswordData.btnKey,
        title: tr("save"),
        borderRadius: 5,
        color: Colors.red,
        margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
        onTap: () => resetPasswordData.resetPassword(context));
  }
}
