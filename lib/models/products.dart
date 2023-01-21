// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

class Product {
  Product(
      {required this.available,
      this.picture,
      required this.price,
      required this.title,
      this.description,
      this.id});

  bool available;
  String? picture;
  double price;
  String title;
  String? id;
  String? description;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        title: json["title"],
        picture: json["picture"],
        description: json["description"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "title": title,
        "picture": picture,
        "description": description,
        "price": price,
      };
//Para hacer una copia de mi modelo.
  Product copy() => Product(
      available: available,
      title: title,
      price: price,
      picture: picture,
      description: description,
      id: id);
}
