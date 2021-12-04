part of 'ActiveAccountImports.dart';

class ActiveAccount extends StatefulWidget {
  final UserModel user;
  final String token;
  ActiveAccount(this.user, this.token);
  @override
  _ActiveAccountState createState() => _ActiveAccountState();
}

class _ActiveAccountState extends State<ActiveAccount> {
  final ActiveAccountData accountData = ActiveAccountData();

  @override
  void initState() {
    accountData.userModel = widget.user;
    accountData.token.text = widget.token;
    super.initState();
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: ListView(
          children: [
            BuildPhoneText(widget.user.mobile),
            BuildActiveCode(accountData),
            BuildActiveButton(accountData),
          ],
        ),
      ),
    );
  }
}
