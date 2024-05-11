import 'package:equatable/equatable.dart';


abstract class BaseProductDetailsModel extends Equatable {
  final String id , name , content , image , category, createdAt, updatedAt;
  final int price, quantity, total;
  final bool isProductExist;


  const BaseProductDetailsModel({
    required this.id ,
    required this.content ,
    required this.name ,
    required this.image ,
    required this.category ,
    required this.createdAt ,
    required this.updatedAt ,
    required this.price ,
    required this.quantity ,
    required this.total ,
    required this.isProductExist ,
  });

  Map<String , dynamic> toJson();

  @override
  List<Object?> get props => [
    isProductExist,
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
  ];
}

enum ProductDetailsEnum {
  id , name, content, image, category,  isProductExist,
  createdAt, updatedAt, price,quantity,total
}


class ProductDetailsModel extends BaseProductDetailsModel {
  const ProductDetailsModel({
    required super.id,
    required super.content,
    required super.name,
    required super.image,
    required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.price,
    required super.quantity,
    required super.total,
    required super.isProductExist,
  });


  factory ProductDetailsModel.fromJson(Map<String , dynamic>json) {
    return ProductDetailsModel(
        id: json[ProductDetailsEnum.id.name],
        content: json[ProductDetailsEnum.content.name],
        name: json[ProductDetailsEnum.name.name],
        image: json[ProductDetailsEnum.image.name],
        category: json[ProductDetailsEnum.category.name],
        createdAt: json[ProductDetailsEnum.createdAt.name],
        updatedAt: json[ProductDetailsEnum.updatedAt.name],
        price: json[ProductDetailsEnum.price.name],
        quantity: json[ProductDetailsEnum.quantity.name],
        total: json[ProductDetailsEnum.total.name],
        isProductExist: json[ProductDetailsEnum.isProductExist.name],
    );
  }

  @override
  Map<String , dynamic> toJson() => {
    ProductDetailsEnum.isProductExist.name : isProductExist,
    ProductDetailsEnum.id.name : id ,
    ProductDetailsEnum.content.name : content ,
    ProductDetailsEnum.name.name : name ,
    ProductDetailsEnum.image.name: image ,
    ProductDetailsEnum.category.name : category ,
    ProductDetailsEnum.createdAt.name : createdAt ,
    ProductDetailsEnum.updatedAt.name : updatedAt ,
    ProductDetailsEnum.price.name : price,
    ProductDetailsEnum.quantity.name : quantity,
    ProductDetailsEnum.total.name : total,
  };

}