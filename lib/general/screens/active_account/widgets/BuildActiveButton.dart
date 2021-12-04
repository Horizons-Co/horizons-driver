part of 'ActiveAccountWidgetsImports.dart';

class BuildActiveButton extends StatelessWidget {
  final ActiveAccountData accountData;

  BuildActiveButton(this.accountData);
  @override
  Widget build(BuildContext context) {
    return LoadingButton(
      btnKey: accountData.btnKey,
      title: tr("activate"),
      borderRadius: 5,
      color: Colors.red,
      onTap: () => accountData.activeAccount(context),
    );
  }
}
