part of 'LanguageImports.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final LanguageData _languageData = LanguageData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.grey.withOpacity(.1),
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
      body: Container(
        color: MyColors.grey.withOpacity(.1),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              MyText(
                title: tr("language"),
                size: 14,
                alien: TextAlign.center,
                color: MyColors.black,
              ),
              SizedBox(
                height: 30,
              ),
              BuildLanguageItem(
                title: "العربية",
                selected: context.read<LangCubit>().state.lang == "ar",
                changeLang: () => _languageData.changeLang(context, "ar"),
              ),
              BuildLanguageItem(
                title: "English",
                selected: context.read<LangCubit>().state.lang == "en",
                changeLang: () => _languageData.changeLang(context, "en"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
