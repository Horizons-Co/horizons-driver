part of 'ContactUsImports.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final ContactUsData contactUsData = ContactUsData();

  @override
  void initState() {
    contactUsData.fetchData(context);
    super.initState();
  }

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
        child: BlocBuilder<GenericCubit<String>, GenericState<String>>(
          cubit: contactUsData.whatsCubit,
          builder: (_, state) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  MyText(
                    title: tr("customerService"),
                    size: 14,
                    alien: TextAlign.center,
                    color: MyColors.black,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BuildContactUsItem(
                    title: tr("contactUsWhatsapp"),
                    image: Res.contactWhatsApp,
                    onTap: () => Utils.launchURL(
                        url:
                            "https://api.whatsapp.com/send?phone=${state.data}"),
                  ),
                  // BuildContactUsItem(
                  //   title: tr("contactUs"),
                  //   onTap: () => Utils.callPhone(phone: state.data),
                  //   image: Res.contactUsMobile,
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
