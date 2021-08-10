import 'dart:io';

class RegisterModel {
  final String userName,
      userPhone,
      userPassword,
      userCity,
      userCountry,
      userNationality,
      userIdentity,
      carMakerId,
      year,
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
      this.carMakerId,
      this.userIdentity,
      this.userCountry,
      this.year,
      this.userId});
}
