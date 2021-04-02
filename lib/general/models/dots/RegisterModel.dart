import 'dart:io';

class RegisterModel {
  final String userName,
      userPhone,
      userPassword,
      userCity,
      userCountry,
      userNationality,
      userIdentity,
      userCarType,
      userCarModel,
      userId;
  final File carLicence, carImage, userImage;

  RegisterModel(
      {this.userName,
      this.userNationality,
      this.userPassword,
      this.userCity,
      this.userPhone,
      this.userImage,
      this.carImage,
      this.carLicence,
      this.userCarModel,
      this.userCarType,
      this.userIdentity,
      this.userCountry,
      this.userId});
}
