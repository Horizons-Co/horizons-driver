part of 'ActiveAccountWidgetsImports.dart';

class BuildPhoneText extends StatelessWidget {
  final String phone;
  BuildPhoneText(this.phone);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            title: "${tr("insertCodeSendTo")} $phone",
            color: MyColors.black,
            alien: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
