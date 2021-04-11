part of 'BuildProfileImports.dart';

class BuildProfileInputs extends StatefulWidget {
  final ProfileData profileData;

  BuildProfileInputs(this.profileData);

  @override
  _BuildProfileInputsState createState() => _BuildProfileInputsState();
}

class _BuildProfileInputsState extends State<BuildProfileInputs> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildProfileTitle(
          title: tr("name"),
          value: user.name,
        ),
        BuildProfileTitle(
          title: tr("phone"),
          value: user.mobile,
        ),
        BuildProfileTitle(
          title: tr("nationality"),
          value: user.nationality.name,
        ),
        BuildProfileTitle(
          title: tr("city"),
          value: user.city.name,
        ),
        BuildProfileTitle(
          title: tr("identityNumber"),
          value: user.idNo,
        ),
        BuildProfileTitle(
          title: tr("carMark"),
          value: user.maker.name,
        ),
        BuildProfileTitle(
          title: tr("year"),
          value: user.year.toString()
        ),
        BuildProfileImage(
          title: tr("carImage"),
          image: user.carImage ?? "",
        ),
        BuildProfileImage(
          title: tr("carLicenceImage"),
          image: user.idImage ?? "",
        ),
        BuildProfileImage(
          title: tr("profileImage"),
          image: user.personalImage ?? "",
        ),
      ],
    );
  }
}
