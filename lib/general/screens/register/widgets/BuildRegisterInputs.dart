part of 'RegisterWidgetsImports.dart';

class BuildRegisterInputs extends StatefulWidget {
  final RegisterData registerData;

  BuildRegisterInputs(this.registerData);

  @override
  _BuildRegisterInputsState createState() => _BuildRegisterInputsState();
}

class _BuildRegisterInputsState extends State<BuildRegisterInputs> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.registerData.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelTextField(
            label: tr("name"),
            action: TextInputAction.next,
            controller: widget.registerData.name,
            type: TextInputType.text,
            validate: (value) => value.validateEmpty(),
            margin: const EdgeInsets.symmetric(vertical: 5),
          ),
          IconTextFiled(
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MyText(
                title: "+966",
              ),
            ),
            label: "55xxxxxxxxx",
            action: TextInputAction.next,
            controller: widget.registerData.phone,
            type: TextInputType.phone,
            validate: (value) => value.validatePhone(),
            margin: const EdgeInsets.symmetric(vertical: 5),
          ),
          IconTextFiled(
            margin: const EdgeInsets.symmetric(vertical: 5),
            label: tr("password"),
            controller: widget.registerData.password,
            action: TextInputAction.done,
            validate: (value) => value.validatePassword(),
            isPassword: true,
          ),
          DropdownTextField<DropDownModel>(
            dropKey: widget.registerData.cityKey,
            label: tr("city"),
            finData: (filter) async =>
                await GeneralRepository(context).getCities(),
            validate: (DropDownModel value) => value.validateDropDown(),
            margin: const EdgeInsets.symmetric(vertical: 5),
            useName: true,
            onChange: widget.registerData.setSelectCity,
          ),
          DropdownTextField<DropDownModel>(
            dropKey: widget.registerData.nationalityKey,
            label: tr("nationality"),
            finData: (filter) async =>
                await GeneralRepository(context).getCountries(),
            validate: (DropDownModel value) => value.validateDropDown(),
            margin: const EdgeInsets.symmetric(vertical: 5),
            useName: true,
            onChange: widget.registerData.setSelectNationality,
          ),
          LabelTextField(
            label: tr("identityNumber"),
            action: TextInputAction.done,
            controller: widget.registerData.identityNumber,
            type: TextInputType.phone,
            validate: (value) => value.validateEmpty(),
            margin: const EdgeInsets.symmetric(vertical: 5),
          ),
          DropdownTextField<DropDownModel>(
            dropKey: widget.registerData.carMarkKey,
            label: tr("carMark"),
            finData: (filter) async =>
                await GeneralRepository(context).getCarMArks(),
            validate: (DropDownModel value) => value.validateDropDown(),
            margin: const EdgeInsets.symmetric(vertical: 5),
            useName: true,
            onChange: widget.registerData.setSelectCarMark,
          ),
          DropdownTextField<DropDownModel>(
            dropKey: widget.registerData.carModelKey,
            label: tr("carModel"),
            finData: (filter) async => await GeneralRepository(context)
                .getCarModel(widget.registerData.carMark.id.toString()),
            validate: (DropDownModel value) => value.validateDropDown(),
            margin: const EdgeInsets.symmetric(vertical: 5),
            useName: true,
            onChange: widget.registerData.setSelectCarModel,
          ),
          InkWellTextField(
            icon: Icon(Icons.image),
            margin: const EdgeInsets.only(top: 5),
            label: tr("carLicenceImage"),
            validate: (value) => value.noValidate,
            onTab: () => widget.registerData.getCarLicenceImage(context),
          ),
          BlocBuilder<GenericCubit<File>, GenericState<File>>(
              cubit: widget.registerData.carLicenceImage,
              builder: (_, state) {
                if (state.data != null) {
                  return Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              widget.registerData.carLicenceImage
                                  .onUpdateData(null);
                            })
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(state.data), fit: BoxFit.fill)),
                  );
                } else {
                  return Container();
                }
              }),
          InkWellTextField(
            margin: const EdgeInsets.only(top: 10),
            validate: (value) => value.noValidate,
            icon: Icon(Icons.image),
            label: tr("carImage"),
            onTab: () => widget.registerData.getCarImage(context),
          ),
          BlocBuilder<GenericCubit<File>, GenericState<File>>(
              cubit: widget.registerData.carImage,
              builder: (_, state) {
                if (state.data != null) {
                  return Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              widget.registerData.carImage.onUpdateData(null);
                            })
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(state.data), fit: BoxFit.fill)),
                  );
                } else {
                  return Container();
                }
              }),
          InkWellTextField(
            validate: (value) => value.noValidate,
            margin: const EdgeInsets.only(top: 10),
            icon: Icon(Icons.image),
            label: tr("profileImage"),
            onTab: () => widget.registerData.getUserImage(context),
          ),
          BlocBuilder<GenericCubit<File>, GenericState<File>>(
              cubit: widget.registerData.userImage,
              builder: (_, state) {
                if (state.data != null) {
                  return Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              widget.registerData.userImage.onUpdateData(null);
                            })
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(state.data), fit: BoxFit.fill)),
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
