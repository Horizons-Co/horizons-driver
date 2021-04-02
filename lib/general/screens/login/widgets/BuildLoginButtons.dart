part of 'LoginWidgetsImports.dart';

class BuildLoginButtons extends StatelessWidget {
  final LoginData loginData;

  BuildLoginButtons(this.loginData);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          LoadingButton(
            onTap: () => loginData.login(context),
            borderRadius: 5,
            title: tr("login"),
            btnKey: loginData.btnKey,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
