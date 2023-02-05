// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Info {
  final String name;
  final String image;
  final String number;
  final String address;
  final String description;
  final String email;
  Info({
    required this.name,
    required this.image,
    required this.number,
    required this.address,
    required this.description,
    required this.email,
  });
  

  Info copyWith({
    String? name,
    String? image,
    String? number,
    String? address,
    String? description,
    String? email,
  }) {
    return Info(
      name: name ?? this.name,
      image: image ?? this.image,
      number: number ?? this.number,
      address: address ?? this.address,
      description: description ?? this.description,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'number': number,
      'address': address,
      'description': description,
      'email': email,
    };
  }

  factory Info.fromSnapshot(DocumentSnapshot map) {
    return Info(
      name: map['name'] as String,
      image: map['image'] as String,
      number: map['number'] as String,
      address: map['address'] as String,
      description: map['description'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromSnapshot(json.decode(source) as DocumentSnapshot);

  @override
  String toString() {
    return 'Info(name: $name, image: $image, number: $number, address: $address, description: $description, email: $email)';
  }

  @override
  bool operator ==(covariant Info other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.image == image &&
      other.number == number &&
      other.address == address &&
      other.description == description &&
      other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      number.hashCode ^
      address.hashCode ^
      description.hashCode ^
      email.hashCode;
  }
}
