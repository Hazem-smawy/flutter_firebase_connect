// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  List<dynamic> description;
  final String image;
  final String price;
  final String offerPrice;
  final String quantity;
  bool status;
  final String cid;
  final DateTime createAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.offerPrice,
    required this.quantity,
    this.status = true,
    required this.cid,
    required this.createAt,
  });

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      id,
      name,
      description,
      image,
      price,
      offerPrice,
      quantity,
      status,
      cid,
      createAt,
    ];
  }

  Product copyWith({
    String? id,
    String? name,
    List<dynamic>? description,
    String? image,
    String? price,
    String? offerPrice,
    String? quantity,
    bool? status,
    String? cid,
    DateTime? createAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      cid: cid ?? this.cid,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'offerPrice': offerPrice,
      'quantity': quantity,
      'status': status,
      'cid': cid,
      'createAt': createAt.millisecondsSinceEpoch,
    };
  }

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    return Product(
      id: snap['id'] as String,
      name: snap['name'] as String,
      description: snap['description'] as List<dynamic>,
      image: snap['image'] as String,
      price: snap['price'] as String,
      offerPrice: snap['offerPrice'] as String,
      quantity: snap['quantity'] as String,
      status: snap['status'] as bool,
      cid: snap['cid'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(snap['createAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromSnapshot(json.decode(source) as DocumentSnapshot);

  @override
  bool get stringify => true;
}
