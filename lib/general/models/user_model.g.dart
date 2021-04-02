// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,
    name: json['name'] as String,
    mobile: json['mobile'] as String,
    nationality: json['nationality'] == null
        ? null
        : Nationality.fromJson(json['nationality'] as Map<String, dynamic>),
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    carModel: json['car_model'] == null
        ? null
        : CarModel.fromJson(json['car_model'] as Map<String, dynamic>),
    idNo: json['id_no'] as String,
    idImage: json['id_image'] as String,
    carImage: json['car_image'] as String,
    personalImage: json['personal_image'] as String,
    isVerified: json['is_verified'] as bool,
    isOnline: json['is_online'] as bool,
    suspended: json['suspended'] as bool,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'nationality': instance.nationality,
      'city': instance.city,
      'car_model': instance.carModel,
      'id_no': instance.idNo,
      'id_image': instance.idImage,
      'car_image': instance.carImage,
      'personal_image': instance.personalImage,
      'is_verified': instance.isVerified,
      'is_online': instance.isOnline,
      'suspended': instance.suspended,
    };

Nationality _$NationalityFromJson(Map<String, dynamic> json) {
  return Nationality(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$NationalityToJson(Nationality instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CarModel _$CarModelFromJson(Map<String, dynamic> json) {
  return CarModel(
    id: json['id'] as int,
    name: json['name'] as String,
    maker: json['maker'] == null
        ? null
        : Maker.fromJson(json['maker'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'maker': instance.maker,
    };

Maker _$MakerFromJson(Map<String, dynamic> json) {
  return Maker(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$MakerToJson(Maker instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
