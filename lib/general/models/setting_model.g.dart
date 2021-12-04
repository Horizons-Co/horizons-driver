// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingModel _$SettingModelFromJson(Map<String, dynamic> json) {
  return SettingModel(
    facebook: json['facebook'] as String,
    instgram: json['instgram'] as String,
    condtions: json['condtions'] as String,
    phone: json['phone'] as String,
    snapchat: json['snapchat'] as String,
    whatsapp: json['whatsapp'] as String,
    twitter: json['twitter'] as String,
    aboutUs: json['aboutUs'] as String,
    delivery: json['delivery'] as int,
    tax: json['tax'] as int,
  );
}

Map<String, dynamic> _$SettingModelToJson(SettingModel instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'instgram': instance.instgram,
      'condtions': instance.condtions,
      'phone': instance.phone,
      'snapchat': instance.snapchat,
      'whatsapp': instance.whatsapp,
      'twitter': instance.twitter,
      'aboutUs': instance.aboutUs,
      'delivery': instance.delivery,
      'tax': instance.tax,
    };
