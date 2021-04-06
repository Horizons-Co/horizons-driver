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
  final GlobalKey<DropdownSearchState> carModelKey = new GlobalKey();
  final GlobalKey<DropdownSearchState> nationalityKey = new GlobalKey();
  DropDownModel city = DropDownModel();
  DropDownModel nationality = DropDownModel();
  DropDownModel carModel = DropDownModel();
  DropDownModel carMark = DropDownModel();

  void setSelectCarMark(DropDownModel model) {
    carMark = model != null ? model : null;
    carModelKey.currentState.changeSelectedItem(null);
  }

  void setSelectCarModel(DropDownModel model) {
    carModel = model != null ? model : null;
  }

  void setSelectCity(DropDownModel model) {
    city = model != null ? model : null;
  }

  void setSelectNationality(DropDownModel model) {
    nationality = model != null ? model : null;
  }

  Future<void> getCarLicenceImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    File image = await Utils.getImage(imageSource: ImageSource.gallery);
    if (image != null) {
      return carLicenceImage.onUpdateData(image);
    }
  }

  Future<void> getCarImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    File image = await Utils.getImage(imageSource: ImageSource.gallery);
    if (image != null) {
      return carImage.onUpdateData(image);
    }
  }

  Future<void> getUserImage(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    File image = await Utils.getImage(imageSource: ImageSource.gallery);
    if (image != null) {
      return userImage.onUpdateData(image);
    }
  }

  // Future<void> fetchData(BuildContext context) async {
  //   List<Country> countries = await GeneralRepository(context).getCountries();
  //   getCountries.onUpdateData(countries);
  //   List<City> cities = await GeneralRepository(context).getCities();
  //   getCities.onUpdateData(cities);
  //   List<CarMarks> carMarks = await GeneralRepository(context).getCarMArks();
  //   getCarMarks.onUpdateData(carMarks);
  //   pageIsLoaded.onUpdateData(true);
  // }

  // Future<void> getCarModel({BuildContext context, String carMarkId}) async {
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   List<CarModel> carModels =
  //       await GeneralRepository(context).getCarModel(carMarkId);
  //   getCarModels.onUpdateData(carModels);
  // }

  Future<void> register(BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (formKey.currentState.validate()) {
      if (!phone.text.startsWith("5")) {
        return LoadingDialog.showSimpleToast(tr("phoneStartWith05"));
      } else if (identityNumber.text.length != 10) {
        return LoadingDialog.showSimpleToast(tr("identityNumberMustBe10"));
      }
      btnKey.currentState.animateForward();
      await GeneralRepository(context).userRegister(RegisterModel(
        userImage: userImage.state.data,
        userCountry: nationality.id.toString(),
        userPhone: "0${phone.text}",
        userName: name.text,
        userCity: city.id.toString(),
        userPassword: password.text,
        carImage: carImage.state.data,
        carLicence: carLicenceImage.state.data,
        userCarModel: carModel.id.toString(),
        userCarType: carMark.id.toString(),
        userIdentity: identityNumber.text,
      ));
      btnKey.currentState.animateReverse();
    }
  }
}
