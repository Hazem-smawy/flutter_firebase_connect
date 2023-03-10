// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String cid;
  final String title;
  final String description;
  final String image;
  final DateTime createAt;
  bool status;
  final int id;
  Category({
    required this.cid,
    required this.title,
    required this.description,
    required this.image,
    required this.createAt,
    this.status = false,
    required this.id,
  });

  Category copyWith({
    String? cid,
    String? title,
    String? description,
    String? image,
    DateTime? createAt,
    bool? status,
    int? id,
  }) {
    return Category(
      cid: cid ?? this.cid,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      createAt: createAt ?? this.createAt,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'title': title,
      'description': description,
      'image': image,
      'createAt': createAt.millisecondsSinceEpoch,
      'status': status,
      'id': id,
    };
  }

  factory Category.fromSnapshot(DocumentSnapshot map) {
    return Category(
      cid: map['cid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      status: map['status'] as bool,
      id: map['id'] as int,
      createAt:  DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      cid,
      title,
      description,
      image,
      createAt,
      status,
      id,
    ];
  }

  static List<Category> categories = [];

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      cid: map['cid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] as int),
      status: map['status'] as bool,
      id: map['id'] as int,
    );
  }
}
