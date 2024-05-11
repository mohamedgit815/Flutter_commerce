import 'package:equatable/equatable.dart';


abstract class BaseCategoryModel extends Equatable {
  final String id , name , content , image , createdAt, updatedAt;


  const BaseCategoryModel({
    required this.id ,
    required this.content ,
    required this.name ,
    required this.image ,
    required this.createdAt ,
    required this.updatedAt ,
  });

  Map<String , dynamic> toJson();

  @override
  List<Object?> get props => [
    id ,
    content ,
    name ,
    image ,
    createdAt ,
    updatedAt ,
  ];
}

enum CategoryEnum {
  id , name, content, image,  createdAt, updatedAt,
}

class CategoryModel extends BaseCategoryModel {
  const CategoryModel({
    required super.id,
    required super.content,
    required super.name,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
  });


  factory CategoryModel.fromJson(Map<String , dynamic>json) {
    return CategoryModel(
        id: json[CategoryEnum.id.name],
        content: json[CategoryEnum.content.name],
        name: json[CategoryEnum.name.name],
        image: json[CategoryEnum.image.name],
        createdAt: json[CategoryEnum.createdAt.name],
        updatedAt: json[CategoryEnum.updatedAt.name],
    );
  }

  @override
  Map<String , dynamic> toJson() => {
    CategoryEnum.id.name : id ,
    CategoryEnum.content.name : content ,
    CategoryEnum.name.name : name ,
    CategoryEnum.image.name: image ,
    CategoryEnum.createdAt.name : createdAt ,
    CategoryEnum.updatedAt.name : updatedAt ,
  };

}