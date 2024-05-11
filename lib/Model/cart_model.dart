import 'package:equatable/equatable.dart';


abstract class BaseCartModel extends Equatable {
  final String id , name ,
      content , image , category,
      createdAt, updatedAt , user;
  final int price , total , quantity;


  const BaseCartModel({
    required this.id ,
    required this.content ,
    required this.name ,
    required this.image ,
    required this.category ,
    required this.createdAt ,
    required this.updatedAt ,
    required this.user ,
    required this.price ,
    required this.total ,
    required this.quantity ,
  });

  Map<String , dynamic> toJson();

  @override
  List<Object?> get props => [
    id ,
    content ,
    name ,
    image ,
    category ,
    createdAt ,
    updatedAt ,
    price ,
    quantity ,
    total ,
    user
  ];
}

enum CartEnum {
  id , name, content, image, category, createdAt, updatedAt, price ,
  product , user, total , quantity
}


class CartModel extends BaseCartModel {
  const CartModel({
    required super.id,
    required super.content,
    required super.name,
    required super.image,
    required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.price,
    required super.user,
    required super.total,
    required super.quantity
  });


  factory CartModel.fromJson(Map<String , dynamic>json) {
    return CartModel(
        id: json[CartEnum.product.name][CartEnum.id.name],
        content: json[CartEnum.product.name][CartEnum.content.name],
        name: json[CartEnum.product.name][CartEnum.name.name],
        image: json[CartEnum.product.name][CartEnum.image.name],
        category: json[CartEnum.product.name][CartEnum.category.name],
        createdAt: json[CartEnum.product.name][CartEnum.createdAt.name],
        updatedAt: json[CartEnum.product.name][CartEnum.updatedAt.name],
        price: json[CartEnum.product.name][CartEnum.price.name],
        user: json[CartEnum.user.name],
        total: json[CartEnum.total.name] ,
        quantity: json[CartEnum.quantity.name]
    );
  }

  @override
  Map<String , dynamic> toJson() => {
    CartEnum.id.name : id ,
    CartEnum.content.name : content ,
    CartEnum.name.name : name ,
    CartEnum.image.name: image ,
    CartEnum.category.name : category ,
    CartEnum.createdAt.name : createdAt ,
    CartEnum.updatedAt.name : updatedAt ,
    CartEnum.price.name : price
  };

}