import 'package:equatable/equatable.dart';


abstract class BaseProductModel extends Equatable {
  final String id , name , content , image , category, createdAt, updatedAt;
  final int price ;


  const BaseProductModel({
    required this.id ,
    required this.content ,
    required this.name ,
    required this.image ,
    required this.category ,
    required this.createdAt ,
    required this.updatedAt ,
    required this.price ,
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
  ];
}

enum ProductEnum {
  id , name, content, image, category, createdAt, updatedAt, price
}


class ProductModel extends BaseProductModel {
  const ProductModel({
    required super.id,
    required super.content,
    required super.name,
    required super.image,
    required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.price
  });


  factory ProductModel.fromJson(Map<String , dynamic>json) {
    return ProductModel(
        id: json[ProductEnum.id.name],
        content: json[ProductEnum.content.name],
        name: json[ProductEnum.name.name],
        image: json[ProductEnum.image.name],
        category: json[ProductEnum.category.name],
        createdAt: json[ProductEnum.createdAt.name],
        updatedAt: json[ProductEnum.updatedAt.name],
        price: json[ProductEnum.price.name]
    );
  }

  @override
  Map<String , dynamic> toJson() => {
    ProductEnum.id.name : id ,
    ProductEnum.content.name : content ,
    ProductEnum.name.name : name ,
    ProductEnum.image.name: image ,
    ProductEnum.category.name : category ,
    ProductEnum.createdAt.name : createdAt ,
    ProductEnum.updatedAt.name : updatedAt ,
    ProductEnum.price.name : price
  };

}