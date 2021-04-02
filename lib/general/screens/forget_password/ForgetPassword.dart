part of 'ForgetPasswordImports.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordData forgetPasswordData = ForgetPasswordData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: ImageIcon(
            AssetImage(Res.removeBlack),
            size: 40,
          ),
          onPressed: () => ExtendedNavigator.root.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: MyText(
                title: "إعادة تعيين كلمة المرور",
                size: 12,
                color: MyColors.black,
                alien: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: MyText(
                title: "اكتب رقم الجوال المسجل",
                size: 12,
                color: MyColors.black,
                alien: TextAlign.center,
              ),
            ),
            BuildForgetPassInput(forgetPasswordData),
            BuildForgetPassButton(forgetPasswordData)
          ],
        ),
      ),
    );
  }
}
