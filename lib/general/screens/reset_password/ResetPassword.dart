part of 'ResetPasswordImports.dart';

class ResetPassword extends StatefulWidget {
  final String userId, phone;
  ResetPassword(this.userId, this.phone);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ResetPasswordData resetPasswordData = ResetPasswordData();
  @override
  void initState() {
    resetPasswordData.userName.text = widget.userId;
    resetPasswordData.phone.text = widget.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.primary,
        leading: IconButton(
          icon: ImageIcon(
            AssetImage(Res.removeBlack),
            size: 40,
          ),
          onPressed: () => ExtendedNavigator.root.pop(),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  title: "${tr("insertCodeSendTo")} ${widget.phone}",
                  color: MyColors.black,
                  alien: TextAlign.center,
                ),
              ],
            ),
          ),
          BuildResetPassInputs(resetPasswordData),
          BuildResetPassButton(resetPasswordData),
        ],
      ),
    );
  }
}
