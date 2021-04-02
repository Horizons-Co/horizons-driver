part of 'RegisterImports.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterData registerData = RegisterData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.primary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              AppBar(
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
              headerLogo(context: context, title: tr("registerNewDriver")),
              BuildRegisterInputs(registerData),
              BuildRegisterButton(registerData),
              BuildHaveAccount(),
            ],
          ),
        ));
  }
}
