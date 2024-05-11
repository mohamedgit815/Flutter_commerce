import 'package:equatable/equatable.dart';


abstract class BaseOrdersModel extends Equatable {
  final String id , status , country , phone , zip,

      createdAt, updatedAt , lat, long , city, user;
  final int total ;


  const BaseOrdersModel({
    required this.id ,
    required this.status ,
    required this.country ,
    required this.zip ,
    required this.phone ,
    required this.createdAt ,
    required this.updatedAt ,
    required this.user ,
    required this.lat ,
    required this.total ,
    required this.long ,
    required this.city
  });

  Map<String , dynamic> toJson();

  @override
  List<Object?> get props => [
    id ,
    status ,
    country ,
    zip ,
    phone ,
    createdAt ,
    updatedAt ,
    lat ,
    long ,
    total ,
    user ,
    city
  ];
}

enum OrdersEnum {
  id , shippingAddress1, shippingAddress2, city, zip, phone, country,
  status, totalPrice, user, createdAt, updatedAt
}


class OrdersModel extends BaseOrdersModel {
  const OrdersModel({
    required super.id,
    required super.city,
    required super.country,
    required super.lat,
    required super.long,
    required super.createdAt,
    required super.updatedAt,
    required super.phone,
    required super.user,
    required super.total,
    required super.status,
    required super.zip
  });


  factory OrdersModel.fromJson(Map<String , dynamic>json) {
    return OrdersModel(
        id: json[OrdersEnum.id.name],
        user: json[OrdersEnum.user.name],
        status: json[OrdersEnum.status.name],
        country: json[OrdersEnum.country.name],
        city: json[OrdersEnum.city.name],
        lat: json[OrdersEnum.shippingAddress1.name],
        long: json[OrdersEnum.shippingAddress2.name],
        createdAt: json[OrdersEnum.createdAt.name],
        updatedAt: json[OrdersEnum.updatedAt.name],
        total: json[OrdersEnum.totalPrice.name] ,
        phone: json[OrdersEnum.phone.name] ,
        zip: json[OrdersEnum.zip.name] ,
    );
  }

  @override
  Map<String , dynamic> toJson() => {
    OrdersEnum.id.name : id ,
    OrdersEnum.user.name : user ,
    OrdersEnum.shippingAddress1.name : lat ,
    OrdersEnum.shippingAddress2.name: long ,
    OrdersEnum.status.name : status ,
    OrdersEnum.country.name : country ,
    OrdersEnum.city.name : city ,
    OrdersEnum.createdAt.name : createdAt ,
    OrdersEnum.updatedAt.name : updatedAt ,
    OrdersEnum.phone.name : phone ,
    OrdersEnum.zip.name : zip ,
    OrdersEnum.totalPrice.name : total ,
  };

}