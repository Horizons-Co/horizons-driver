part of 'LoginWidgetsImports.dart';

class BuildLoginInputs extends StatefulWidget {
  final LoginData loginData;

  BuildLoginInputs(this.loginData);
  @override
  _BuildLoginInputsState createState() => _BuildLoginInputsState();
}

class _BuildLoginInputsState extends State<BuildLoginInputs> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginData.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTextFiled(
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MyText(
                title: "+966",
              ),
            ),
            label: "55xxxxxxxxx",
            action: TextInputAction.next,
            controller: widget.loginData.phone,
            type: TextInputType.phone,
            maxLength: 9,
            margin: const EdgeInsets.only(top: 30),
            validate: (value) => value.validatePhone(),
            onChange: widget.loginData.onChangePhone,
          ),
          BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
              cubit: widget.loginData.showPassCubit,
              builder: (_, state) {
                return IconTextFiled(
                  label: tr("password"),
                  controller: widget.loginData.password,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  validate: (value) => value.validateEmpty(),
                  // suffixIcon: IconButton(
                  //     onPressed: () => widget.loginData.showPassCubit
                  //         .onUpdateData(!state.data),
                  //     icon: Icon(Icons.remove_red_eye)),
                  isPassword: !state.changed,
                  submit: (val) => widget.loginData.login(context),
                );
              })
        ],
      ),
    );
  }
}
