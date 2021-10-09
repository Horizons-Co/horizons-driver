import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable(nullable: true)
class OrderItemModel {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "no")
  int no;
  @JsonKey(name: "client")
  Client client;
  @JsonKey(name: "merchant")
  Merchant merchant;
  @JsonKey(name: "branch")
  Branch branch;
  @JsonKey(name: "driver")
  Driver driver;
  @JsonKey(name: "item_image")
  String itemImage;
  @JsonKey(name: "status")
  Status status;
  @JsonKey(name: "notes")
  String notes;
  @JsonKey(name: "type")
  Type type;
  @JsonKey(name: "scheduled_at")
  dynamic scheduledAt;
  @JsonKey(name: "fees_payment_method")
  FeesPaymentMethod feesPaymentMethod;
  @JsonKey(name: "pickup_point")
  PickupPoint pickupPoint;
  @JsonKey(name: "price")
  String price;
  @JsonKey(name: "total")
  String total;
  @JsonKey(name: "currency")
  String currency;
  @JsonKey(name: "formatted_price")
  String formattedPrice;
  @JsonKey(name: "collection_method")
  CollectionMethod collectionMethod;
  @JsonKey(name: "delivery_fees")
  String deliveryFees;
  @JsonKey(name: "vat")
  Vat vat;
  @JsonKey(name: "is_multiple")
  bool isMultiple;
  @JsonKey(name: "quantity")
  dynamic quantity;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  @JsonKey(name: "assigned_at")
  String assignedAt;

  @JsonKey(name: "timeline")
  List<Timeline> timeline;
  @JsonKey(name: "logs")
  List<Log> logs;

  OrderItemModel(
      {this.id,
      this.no,
      this.client,
      this.merchant,
      this.branch,
      this.driver,
      this.itemImage,
      this.status,
      this.notes,
      this.type,
      this.scheduledAt,
      this.feesPaymentMethod,
      this.pickupPoint,
      this.price,
      this.total,
      this.currency,
      this.formattedPrice,
      this.collectionMethod,
      this.deliveryFees,
      this.vat,
      this.isMultiple,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.assignedAt,
      this.timeline,
      this.logs});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}

@JsonSerializable(nullable: true)
class CollectionMethod {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  CollectionMethod({this.id, this.name});

  factory CollectionMethod.fromJson(Map<String, dynamic> json) =>
      _$CollectionMethodFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionMethodToJson(this);
}

@JsonSerializable(nullable: true)
class Client {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "mobile")
  String mobile;
  @JsonKey(name: "district")
  District district;
  @JsonKey(name: "lat")
  String lat;
  @JsonKey(name: "lag")
  String lag;

  Client({this.name, this.mobile, this.district, this.lat, this.lag});

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable(nullable: true)
class District {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  District({this.id, this.name});

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}

@JsonSerializable(nullable: true)
class Merchant {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "mobile")
  String mobile;
  @JsonKey(name: "city")
  City city;
  @JsonKey(name: "bank")
  Bank bank;
  @JsonKey(name: "bank_account")
  String bankAccount;
  @JsonKey(name: "iban")
  String iban;
  @JsonKey(name: "official_name")
  String officialName;
  @JsonKey(name: "business_activity")
  String businessActivity;
  @JsonKey(name: "logo_url")
  dynamic logoUrl;
  @JsonKey(name: "cr_no")
  String crNo;
  @JsonKey(name: "manager_name")
  String managerName;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "suspended")
  bool suspended;
  @JsonKey(name: "is_active")
  bool isActive;
  @JsonKey(name: "settings")
  Settings settings;

  Merchant(
      {this.id,
      this.name,
      this.mobile,
      this.city,
      this.bank,
      this.bankAccount,
      this.iban,
      this.officialName,
      this.businessActivity,
      this.logoUrl,
      this.crNo,
      this.managerName,
      this.phone,
      this.email,
      this.suspended,
      this.isActive,
      this.settings});

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantToJson(this);
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
class Bank {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  Bank({this.id, this.name});

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
}

@JsonSerializable(nullable: true)
class Settings {
  @JsonKey(name: "multiple_shipments")
  bool multipleShipments;
  @JsonKey(name: "delivery_fees")
  dynamic deliveryFees;
  @JsonKey(name: "multiple_shipments_min")
  int multipleShipmentsMin;
  @JsonKey(name: "multiple_shipments_max")
  int multipleShipmentsMax;

  Settings(
      {this.multipleShipments,
      this.deliveryFees,
      this.multipleShipmentsMin,
      this.multipleShipmentsMax});

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}

@JsonSerializable(nullable: true)
class Branch {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "district")
  District district;
  @JsonKey(name: "mobile")
  String mobile;
  @JsonKey(name: "lat")
  String lat;
  @JsonKey(name: "lng")
  String lng;
  @JsonKey(name: "manager_name")
  String managerName;
  @JsonKey(name: "phone")
  String phone;

  Branch(
      {this.id,
      this.name,
      this.code,
      this.district,
      this.mobile,
      this.lat,
      this.lng,
      this.managerName,
      this.phone});

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}

@JsonSerializable(nullable: true)
class Driver {
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
  dynamic carModel;
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
  @JsonKey(name: "suspended")
  bool suspended;

  Driver(
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
      this.suspended});

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
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
class Status {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  Status({this.id, this.name});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable(nullable: true)
class Type {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  Type({this.id, this.name});

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable(nullable: true)
class FeesPaymentMethod {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  FeesPaymentMethod({this.id, this.name});

  factory FeesPaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$FeesPaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$FeesPaymentMethodToJson(this);
}

@JsonSerializable(nullable: true)
class PickupPoint {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  PickupPoint({this.id, this.name});

  factory PickupPoint.fromJson(Map<String, dynamic> json) =>
      _$PickupPointFromJson(json);

  Map<String, dynamic> toJson() => _$PickupPointToJson(this);
}

@JsonSerializable(nullable: true)
class Vat {
  @JsonKey(name: "rate")
  String rate;
  @JsonKey(name: "amount")
  String amount;

  Vat({this.rate, this.amount});

  factory Vat.fromJson(Map<String, dynamic> json) => _$VatFromJson(json);

  Map<String, dynamic> toJson() => _$VatToJson(this);
}

@JsonSerializable(nullable: true)
class Timeline {
  @JsonKey(name: "event")
  String event;
  @JsonKey(name: "created_by")
  String createdBy;
  @JsonKey(name: "created_at")
  String createdAt;

  Timeline({this.event, this.createdBy, this.createdAt});

  factory Timeline.fromJson(Map<String, dynamic> json) =>
      _$TimelineFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineToJson(this);
}

@JsonSerializable(nullable: true)
class Log {
  @JsonKey(name: "status")
  Status status;
  @JsonKey(name: "updated_by")
  UpdatedBy updatedBy;
  @JsonKey(name: "notes")
  String notes;
  @JsonKey(name: "datetime")
  String datetime;
  @JsonKey(name: "date")
  String date;
  @JsonKey(name: "time")
  String time;
  @JsonKey(name: "for_humans")
  String forHumans;

  Log(
      {this.status,
      this.updatedBy,
      this.notes,
      this.datetime,
      this.date,
      this.time,
      this.forHumans});

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map<String, dynamic> toJson() => _$LogToJson(this);
}

@JsonSerializable(nullable: true)
class UpdatedBy {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "type")
  String type;

  UpdatedBy({this.name, this.type});

  factory UpdatedBy.fromJson(Map<String, dynamic> json) =>
      _$UpdatedByFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatedByToJson(this);
}
