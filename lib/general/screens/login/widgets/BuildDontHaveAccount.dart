part of 'LoginWidgetsImports.dart';

class BuildDontHaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: DefaultButton(
        onTap: () => ExtendedNavigator.root.push(Routes.register),
        borderRadius: BorderRadius.circular(5),
        title: tr("registerNewDriver"),
        textColor: Colors.red,
        borderColor: Colors.red,
      ),
    );
  }
}
