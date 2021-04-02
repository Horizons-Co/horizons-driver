import 'package:json_annotation/json_annotation.dart';

part 'car_marks.g.dart';

@JsonSerializable(nullable: true)
class CarMarks {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  CarMarks({this.id, this.name});

  factory CarMarks.fromJson(Map<String, dynamic> json) =>
      _$CarMarksFromJson(json);

  Map<String, dynamic> toJson() => _$CarMarksToJson(this);
}
