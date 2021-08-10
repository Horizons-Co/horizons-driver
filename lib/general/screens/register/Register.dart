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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics:
          BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
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
