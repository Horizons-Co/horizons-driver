part of 'LoginImports.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginData loginData = LoginData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              if (context.read<LangCubit>().state.lang == "en") {
                Utils.changeLanguage("ar", context);
              } else {
                Utils.changeLanguage("en", context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: MyText(
                  title: context.read<LangCubit>().state.lang == "ar"
                      ? "English"
                      : "العربية",
                  color: MyColors.black,
                ),
              ),
            ),
          )
        ],
        backgroundColor: MyColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            headerLogo(context: context),
            BuildLoginInputs(loginData),
            BuildLoginButtons(loginData),
            BuildForgetPass(),
            BuildDontHaveAccount(),
            Container(
              alignment: Alignment.bottomCenter,
              child: MyText(
                title: "Powered by \n Horizons Delivery",
                color: MyColors.black,
                alien: TextAlign.center,
                size: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
