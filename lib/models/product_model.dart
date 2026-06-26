import 'dart:convert';
import 'dart:ui';

class ProductModel {
  final String name;
  final String description;
  final int price;
  final String image;

  //constructor
  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  // objec -> map
  Map<String, dynamic> topMap(){
    return {
      'name' : name,
      'description' : description,
      'price' : price,
      'image' : image
    };
  }

  // map -> object
  factory ProductModel.fromMap(
    Map<String, dynamic> map,
  ){
    return ProductModel(
      name: map['name'] ?? '', 
      description: map['description'] ?? '', 
      price: map['price'] ?? 0,
      image: map['price'] ?? '',
    );
  }

  // object string
  String toJson() => jsonEncode(topMap());

  // string object
  factory ProductModel.fromJson(String source){
    return ProductModel.fromMap(
      jsonDecode(source),
    );
  }
}