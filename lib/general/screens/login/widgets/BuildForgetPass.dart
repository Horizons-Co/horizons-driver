part of 'LoginWidgetsImports.dart';

class BuildForgetPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ExtendedNavigator.root.push(Routes.forgetPassword),
      child: MyText(
        title: tr("forgetPassword"),
        size: 10,
        alien: TextAlign.center,
        color: MyColors.black,
      ),
    );
  }
}
