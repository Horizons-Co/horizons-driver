part of 'ContactUsImports.dart';

class ContactUsData {
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();

  final GenericCubit<String> whatsCubit = new GenericCubit("");

  void fetchData(BuildContext context)async{
    LoadingDialog.showLoadingDialog();
    var data = await GeneralRepository(context).getContactUs();
    String phone = data.startsWith("0")?data.replaceFirst("0", "+966"):data;
    whatsCubit.onUpdateData(phone);
    EasyLoading.dismiss();
  }


}
