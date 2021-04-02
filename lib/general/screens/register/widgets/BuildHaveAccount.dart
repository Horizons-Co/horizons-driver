part of 'RegisterWidgetsImports.dart';

class BuildHaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            title: tr("byRegisterTouAcceptTerms"),
            size: 10,
            color: MyColors.black,
          ),
        ],
      ),
    );
  }
}
