part of "LocationPermissionImports.dart";

class LocationPermission extends StatefulWidget {
  @override
  _LocationPermissionState createState() => _LocationPermissionState();
}

class _LocationPermissionState extends State<LocationPermission> {
  final LocationPermissionData _locationPermissionData =
      LocationPermissionData();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: MyColors.white,
          leading: IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.blue,
            ),
            onPressed: () => Utils.launchURL(
                url: "https://horizonsapp.sa/privacy-policy.html"),
          ),
        ),
        body: BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
          cubit: _locationPermissionData.showReviewCubit,
          builder: (_, state) {
            if (state.data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Res.map,
                    width: 72,
                    height: 72,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyText(
                    title:
                        "This app collects location data to enable tracking orders location to let know it's place even when the app is closed or not in use",
                    size: 12,
                    color: MyColors.black,
                    alien: TextAlign.center,
                  ),
                ],
              );
            } else {
              return ListView(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 30,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    Res.map,
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MyText(
                      title:
                          "This app collects location data to enable tracking orders location to let know it's place even when the app is closed or not in use",
                      size: 14,
                      alien: TextAlign.center,
                      color: MyColors.black,
                    ),
                  ),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () =>
                    _locationPermissionData.acceptBackgroundLocation(context),
                child: MyText(
                  title: "Turn on",
                  size: 12,
                  color: Colors.blue,
                ),
              ),
              InkWell(
                onTap: () => ExtendedNavigator.of(context).push(Routes.login),
                child: MyText(
                  title: "No thanks",
                  size: 12,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
