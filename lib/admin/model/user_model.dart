// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  String imageUrl;
  bool isAdmin;
  User({
    required this.name,
    required this.email,
    this.imageUrl = '',
    this.isAdmin = false,
  });

  User copyWith({
    String? name,
    String? email,
    String? imageUrl,
    bool? isAdmin,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'isAdmin': isAdmin,
    };
  }

  factory User.fromSnapshot(DocumentSnapshot map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $name, email: $email, imageUrl: $imageUrl, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        isAdmin.hashCode;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      isAdmin: map['isAdmin'] as bool,
    );
  }
}
