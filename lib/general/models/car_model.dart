import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable(nullable: true)
class CarModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "car_maker_id")
  int carMakerId;
  @JsonKey(name: "name")
  String name;

  CarModel({this.id, this.carMakerId, this.name});

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
