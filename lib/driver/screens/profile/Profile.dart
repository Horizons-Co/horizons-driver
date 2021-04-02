part of 'ProfileImports.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileData _profileData = ProfileData();
  @override
  void initState() {
    _profileData.fetchData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.grey.withOpacity(.1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              MyText(
                title: tr("myInfo"),
                size: 14,
                alien: TextAlign.center,
                color: MyColors.black,
              ),
              SizedBox(
                height: 30,
              ),
              BuildProfileInputs(_profileData),
            ],
          ),
        ));
  }
}
