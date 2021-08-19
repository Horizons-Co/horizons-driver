part of 'RegisterImports.dart';

class RegisterData {
  final GlobalKey<CustomButtonState> btnKey =
      new GlobalKey<CustomButtonState>();
  final GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController identityNumber = TextEditingController();
  final GenericCubit<File> carLicenceImage = GenericCubit<File>(null);
  final GenericCubit<File> carImage = GenericCubit<File>(null);
  final GenericCubit<File> userImage = GenericCubit<File>(null);
  final GlobalKey<DropdownSearchState> cityKey = new GlobalKey();
  final GlobalKey<DropdownSearchState> carMarkKey = new GlobalKey();
  final GlobalKey<DropdownSearchState> yearKey = new GlobalKey();
  final GlobalKey<DropdownSearchState> nationalityKey = new GlobalKey();
  DropDownModel city = DropDownModel();
  DropDownModel nationality = DropDownModel();
  DropDownModel carMark = DropDownModel();
  DropDownModel year = DropDownModel();

  void setSelectCarMark(DropDownModel model) {
    carMark = model != null ? model : null;
    yearKey.currentState.changeSelectedItem(null);
  }

  void setSelectCarYear(DropDownModel model) {
    year = model;
  }

  void setSelectCity(DropDownModel model) {
    city = model != null ? model : null;
  }

  void setSelectNationality(DropDownModel model) {
    nationality = model != null ? model : null;
  }

  Future<void> getCarLicenceImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    LoadingDialog.showLoadingView();
    File image = await Utils.getImageFile();
    if (image != null) {
      var file = await compressAndGetFile(image);
      return carLicenceImage.onUpdateData(file);
    }
    EasyLoading.dismiss();
  }

  Future<void> getCarImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    LoadingDialog.showLoadingView();
    File image = await Utils.getImageFile();
    if (image != null) {
      var file = await compressAndGetFile(image);
      return carImage.onUpdateData(file);
    }
    EasyLoading.dismiss();
  }

  Future<void> getUserImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    LoadingDialog.showLoadingView();
    File image = await Utils.getImageFile();
    if (image != null) {
      var file = await compressAndGetFile(image);
      return userImage.onUpdateData(file);
    }
    EasyLoading.dismiss();
  }

  yearDatePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {},
      minTime: DateTime(1800),
      currentTime: DateTime.now(),
      maxTime: DateTime.now(),
      theme: DatePickerTheme(
          itemStyle: GoogleFonts.roboto(fontSize: 18, color: MyColors.black)),
      locale:
          context.locale.languageCode == "en" ? LocaleType.en : LocaleType.ar,
    );
  }

  Future<File> compressAndGetFile(File file) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      "$dir/${file.path.split("/").last}",
      quality: 60,
      rotate: 360,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  onChangePhone(String value) {
    if (phone.text.startsWith("0")) {
      return LoadingDialog.showSimpleToast(tr("phoneValidation0"));
    }
  }

  Future<void> register(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState.validate()) {
      if (!phone.text.startsWith("5")) {
        return LoadingDialog.showSimpleToast(tr("phoneStartWith05"));
      } else if (phone.text.startsWith("0")) {
        return LoadingDialog.showSimpleToast(tr("phoneValidation"));
      } else if (identityNumber.text.length != 10) {
        return LoadingDialog.showSimpleToast(tr("identityNumberMustBe10"));
      }
      btnKey.currentState.animateForward();
      await GeneralRepository(context).userRegister(RegisterModel(
          userImage: userImage.state.data,
          userCountry: nationality.id == null ? "1" : nationality.id.toString(),
          userPhone: "0${phone.text}",
          userName: name.text,
          userCity: city.id.toString(),
          userPassword: password.text,
          carImage: carImage.state.data,
          carLicence: carLicenceImage.state.data,
          carMakerId: carMark.id.toString(),
          userIdentity: identityNumber.text,
          year: year.name));
      btnKey.currentState.animateReverse();
    }
  }
}
