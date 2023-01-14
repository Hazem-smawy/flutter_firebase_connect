// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  
  final String cid;
  final String title;
  final String description;
  final String cimage;
  bool cstatus;
  final int id;
  Category({
    required this.cid,
    required this.title,
    required this.description,
    required this.cimage,
    this.cstatus = false,
    required this.id,
  });

  Category copyWith({
    String? cid,
    String? title,
    String? description,
    String? cimage,
    bool? cstatus,
    int? id,
  }) {
    return Category(
      cid: cid ?? this.cid,
      title: title ?? this.title,
      description: description ?? this.description,
      cimage: cimage ?? this.cimage,
      cstatus: cstatus ?? this.cstatus,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'title': title,
      'description': description,
      'cimage': cimage,
      'cstatus': cstatus,
      'id': id,
    };
  }

  factory Category.fromSnapshot(DocumentSnapshot map) {
    return Category(
      cid: map['cid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      cimage: map['cimage'] as String,
      cstatus: map['cstatus'] as bool,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromSnapshot(json.decode(source) as DocumentSnapshot);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      cid,
      title,
      description,
      cimage,
      cstatus,
      id,
    ];
  }

  static List<Category> categories = [];
}
