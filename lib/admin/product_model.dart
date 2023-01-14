import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final bool isRecommended;
  final bool isPopular;
  double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.isRecommended,
    required this.isPopular,
    this.price = 0,
    this.quantity = 0,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      category,
      description,
      imageUrl,
      isRecommended,
      isPopular,
      price,
      quantity,
    ];
  }

  Product copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    bool? isRecommended,
    bool? isPopular,
    double? price,
    int? quantity,
  }) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        isRecommended: isRecommended ?? this.isRecommended,
        isPopular: isPopular ?? this.isPopular,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'price': price,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        category: map['category'],
        description: map['description'],
        imageUrl: map['imageUrl'],
        isRecommended: map['isRecommended'],
        isPopular: map['isPopular'],
        price: map['price'],
        quantity: map['quantity']);
  }

  String toJson() => json.encode(toMap());
  factory Product.fromJson(String sourse) =>
      Product.fromMap(json.decode(sourse));

  bool get stringify => true;
}
