import 'package:json_annotation/json_annotation.dart';

part 'setting_model.g.dart';

@JsonSerializable(nullable: true)
class SettingModel {
  @JsonKey(name: "facebook")
  String facebook;
  @JsonKey(name: "instgram")
  String instgram;
  @JsonKey(name: "condtions")
  String condtions;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "snapchat")
  String snapchat;
  @JsonKey(name: "whatsapp")
  String whatsapp;
  @JsonKey(name: "twitter")
  String twitter;
  @JsonKey(name: "aboutUs")
  String aboutUs;
  @JsonKey(name: "delivery")
  int delivery;
  @JsonKey(name: "tax")
  int tax;

  SettingModel(
      {this.facebook,
      this.instgram,
      this.condtions,
      this.phone,
      this.snapchat,
      this.whatsapp,
      this.twitter,
      this.aboutUs,
      this.delivery,
      this.tax});

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}
