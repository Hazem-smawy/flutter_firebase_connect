// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ShowSlider extends Equatable {
  final String id;
  final String title;
  final String description;
  final String image;
  bool status;
   ShowSlider({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
     this.status = false,
  });

  ShowSlider copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    bool? status,
  }) {
    return ShowSlider(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'status': status,
    };
  }

  factory ShowSlider.fromSnapshot(DocumentSnapshot map) {
    return ShowSlider(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowSlider.fromJson(String source) => ShowSlider.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      image,
      status,
    ];
  }

  factory ShowSlider.fromMap(Map<String, dynamic> map) {
    return ShowSlider(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      status: map['status'] as bool,
    );
  }
}
