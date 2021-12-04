import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(nullable: true)
class Country {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "name")
  String name;

  Country({this.id, this.code, this.name});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
