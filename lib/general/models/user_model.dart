import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(nullable: true)
class UserModel {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "mobile")
  String mobile;
  @JsonKey(name: "nationality")
  Nationality nationality;
  @JsonKey(name: "city")
  City city;
  @JsonKey(name: "car_model")
  CarModel carModel;
  @JsonKey(name: "id_no")
  String idNo;
  @JsonKey(name: "id_image")
  String idImage;
  @JsonKey(name: "car_image")
  String carImage;
  @JsonKey(name: "personal_image")
  String personalImage;
  @JsonKey(name: "is_verified")
  bool isVerified;
  @JsonKey(name: "is_online")
  bool isOnline;
  @JsonKey(name: "is_active")
  bool isActive;
  @JsonKey(name: "suspended")
  bool suspended;

  UserModel(
      {this.id,
      this.name,
      this.mobile,
      this.nationality,
      this.city,
      this.carModel,
      this.idNo,
      this.idImage,
      this.carImage,
      this.personalImage,
      this.isVerified,
      this.isOnline,
      this.isActive,
      this.suspended});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(nullable: true)
class Nationality {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  Nationality({this.id, this.name});

  factory Nationality.fromJson(Map<String, dynamic> json) =>
      _$NationalityFromJson(json);

  Map<String, dynamic> toJson() => _$NationalityToJson(this);
}

@JsonSerializable(nullable: true)
class City {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  City({this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable(nullable: true)
class CarModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "maker")
  Maker maker;

  CarModel({this.id, this.name, this.maker});

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable(nullable: true)
class Maker {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  Maker({this.id, this.name});

  factory Maker.fromJson(Map<String, dynamic> json) => _$MakerFromJson(json);

  Map<String, dynamic> toJson() => _$MakerToJson(this);
}
