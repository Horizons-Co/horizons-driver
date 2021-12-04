import 'package:json_annotation/json_annotation.dart';

part 'intro_model.g.dart';

@JsonSerializable(nullable: true)
class IntroModel {
  @JsonKey(name: "title1")
  String title1;
  @JsonKey(name: "description1")
  String description1;
  @JsonKey(name: "title2")
  String title2;
  @JsonKey(name: "description2")
  String description2;
  @JsonKey(name: "title3")
  String title3;
  @JsonKey(name: "description3")
  String description3;

  IntroModel(
      {this.title1,
      this.description1,
      this.title2,
      this.description2,
      this.title3,
      this.description3});

  factory IntroModel.fromJson(Map<String, dynamic> json) =>
      _$IntroModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntroModelToJson(this);
}
