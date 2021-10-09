// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) {
  return OrderItemModel(
    id: json['id'] as String,
    no: json['no'] as int,
    client: json['client'] == null
        ? null
        : Client.fromJson(json['client'] as Map<String, dynamic>),
    merchant: json['merchant'] == null
        ? null
        : Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
    branch: json['branch'] == null
        ? null
        : Branch.fromJson(json['branch'] as Map<String, dynamic>),
    driver: json['driver'] == null
        ? null
        : Driver.fromJson(json['driver'] as Map<String, dynamic>),
    itemImage: json['item_image'] as String,
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    notes: json['notes'] as String,
    type: json['type'] == null
        ? null
        : Type.fromJson(json['type'] as Map<String, dynamic>),
    scheduledAt: json['scheduled_at'],
    feesPaymentMethod: json['fees_payment_method'] == null
        ? null
        : FeesPaymentMethod.fromJson(
            json['fees_payment_method'] as Map<String, dynamic>),
    pickupPoint: json['pickup_point'] == null
        ? null
        : PickupPoint.fromJson(json['pickup_point'] as Map<String, dynamic>),
    price: json['price'] as String,
    total: json['total'] as String,
    currency: json['currency'] as String,
    formattedPrice: json['formatted_price'] as String,
    collectionMethod: json['collection_method'] == null
        ? null
        : CollectionMethod.fromJson(
            json['collection_method'] as Map<String, dynamic>),
    deliveryFees: json['delivery_fees'] as String,
    vat: json['vat'] == null
        ? null
        : Vat.fromJson(json['vat'] as Map<String, dynamic>),
    isMultiple: json['is_multiple'] as bool,
    quantity: json['quantity'],
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    assignedAt: json['assigned_at'] as String,
    timeline: (json['timeline'] as List)
        ?.map((e) =>
            e == null ? null : Timeline.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    logs: (json['logs'] as List)
        ?.map((e) => e == null ? null : Log.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'client': instance.client,
      'merchant': instance.merchant,
      'branch': instance.branch,
      'driver': instance.driver,
      'item_image': instance.itemImage,
      'status': instance.status,
      'notes': instance.notes,
      'type': instance.type,
      'scheduled_at': instance.scheduledAt,
      'fees_payment_method': instance.feesPaymentMethod,
      'pickup_point': instance.pickupPoint,
      'price': instance.price,
      'total': instance.total,
      'currency': instance.currency,
      'formatted_price': instance.formattedPrice,
      'collection_method': instance.collectionMethod,
      'delivery_fees': instance.deliveryFees,
      'vat': instance.vat,
      'is_multiple': instance.isMultiple,
      'quantity': instance.quantity,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'assigned_at': instance.assignedAt,
      'timeline': instance.timeline,
      'logs': instance.logs,
    };

CollectionMethod _$CollectionMethodFromJson(Map<String, dynamic> json) {
  return CollectionMethod(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CollectionMethodToJson(CollectionMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Client _$ClientFromJson(Map<String, dynamic> json) {
  return Client(
    name: json['name'] as String,
    mobile: json['mobile'] as String,
    district: json['district'] == null
        ? null
        : District.fromJson(json['district'] as Map<String, dynamic>),
    lat: json['lat'] as String,
    lag: json['lag'] as String,
  );
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'district': instance.district,
      'lat': instance.lat,
      'lag': instance.lag,
    };

District _$DistrictFromJson(Map<String, dynamic> json) {
  return District(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Merchant _$MerchantFromJson(Map<String, dynamic> json) {
  return Merchant(
    id: json['id'] as String,
    name: json['name'] as String,
    mobile: json['mobile'] as String,
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    bank: json['bank'] == null
        ? null
        : Bank.fromJson(json['bank'] as Map<String, dynamic>),
    bankAccount: json['bank_account'] as String,
    iban: json['iban'] as String,
    officialName: json['official_name'] as String,
    businessActivity: json['business_activity'] as String,
    logoUrl: json['logo_url'],
    crNo: json['cr_no'] as String,
    managerName: json['manager_name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    suspended: json['suspended'] as bool,
    isActive: json['is_active'] as bool,
    settings: json['settings'] == null
        ? null
        : Settings.fromJson(json['settings'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'city': instance.city,
      'bank': instance.bank,
      'bank_account': instance.bankAccount,
      'iban': instance.iban,
      'official_name': instance.officialName,
      'business_activity': instance.businessActivity,
      'logo_url': instance.logoUrl,
      'cr_no': instance.crNo,
      'manager_name': instance.managerName,
      'phone': instance.phone,
      'email': instance.email,
      'suspended': instance.suspended,
      'is_active': instance.isActive,
      'settings': instance.settings,
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

Bank _$BankFromJson(Map<String, dynamic> json) {
  return Bank(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return Settings(
    multipleShipments: json['multiple_shipments'] as bool,
    deliveryFees: json['delivery_fees'],
    multipleShipmentsMin: json['multiple_shipments_min'] as int,
    multipleShipmentsMax: json['multiple_shipments_max'] as int,
  );
}

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'multiple_shipments': instance.multipleShipments,
      'delivery_fees': instance.deliveryFees,
      'multiple_shipments_min': instance.multipleShipmentsMin,
      'multiple_shipments_max': instance.multipleShipmentsMax,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return Branch(
    id: json['id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    district: json['district'] == null
        ? null
        : District.fromJson(json['district'] as Map<String, dynamic>),
    mobile: json['mobile'] as String,
    lat: json['lat'] as String,
    lng: json['lng'] as String,
    managerName: json['manager_name'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'district': instance.district,
      'mobile': instance.mobile,
      'lat': instance.lat,
      'lng': instance.lng,
      'manager_name': instance.managerName,
      'phone': instance.phone,
    };

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return Driver(
    id: json['id'] as String,
    name: json['name'] as String,
    mobile: json['mobile'] as String,
    nationality: json['nationality'] == null
        ? null
        : Nationality.fromJson(json['nationality'] as Map<String, dynamic>),
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    carModel: json['car_model'],
    idNo: json['id_no'] as String,
    idImage: json['id_image'] as String,
    carImage: json['car_image'] as String,
    personalImage: json['personal_image'] as String,
    isVerified: json['is_verified'] as bool,
    isOnline: json['is_online'] as bool,
    suspended: json['suspended'] as bool,
  );
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
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

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Type _$TypeFromJson(Map<String, dynamic> json) {
  return Type(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

FeesPaymentMethod _$FeesPaymentMethodFromJson(Map<String, dynamic> json) {
  return FeesPaymentMethod(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$FeesPaymentMethodToJson(FeesPaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

PickupPoint _$PickupPointFromJson(Map<String, dynamic> json) {
  return PickupPoint(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$PickupPointToJson(PickupPoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Vat _$VatFromJson(Map<String, dynamic> json) {
  return Vat(
    rate: json['rate'] as String,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$VatToJson(Vat instance) => <String, dynamic>{
      'rate': instance.rate,
      'amount': instance.amount,
    };

Timeline _$TimelineFromJson(Map<String, dynamic> json) {
  return Timeline(
    event: json['event'] as String,
    createdBy: json['created_by'] as String,
    createdAt: json['created_at'] as String,
  );
}

Map<String, dynamic> _$TimelineToJson(Timeline instance) => <String, dynamic>{
      'event': instance.event,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
    };

Log _$LogFromJson(Map<String, dynamic> json) {
  return Log(
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    updatedBy: json['updated_by'] == null
        ? null
        : UpdatedBy.fromJson(json['updated_by'] as Map<String, dynamic>),
    notes: json['notes'] as String,
    datetime: json['datetime'] as String,
    date: json['date'] as String,
    time: json['time'] as String,
    forHumans: json['for_humans'] as String,
  );
}

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'status': instance.status,
      'updated_by': instance.updatedBy,
      'notes': instance.notes,
      'datetime': instance.datetime,
      'date': instance.date,
      'time': instance.time,
      'for_humans': instance.forHumans,
    };

UpdatedBy _$UpdatedByFromJson(Map<String, dynamic> json) {
  return UpdatedBy(
    name: json['name'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$UpdatedByToJson(UpdatedBy instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };
