part of 'ProfileImports.dart';

class ProfileData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  Future<void> fetchData(BuildContext context) async {
    await DriverRepository(context).getUserData();
  }
}
