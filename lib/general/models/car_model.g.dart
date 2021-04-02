// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) {
  return CarModel(
    id: json['id'] as int,
    carMakerId: json['car_maker_id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'car_maker_id': instance.carMakerId,
      'name': instance.name,
    };
