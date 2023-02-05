// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class About {
  final String id;
  final String title;
  List<dynamic>  description;
  About({
    required this.id,
    required this.title,
    required this.description,
  });

  About copyWith({
    String? id,
    String? title,
    List<dynamic>? description,
  }) {
    return About(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory About.fromSnapshot(DocumentSnapshot map) {
    return About(
      id:map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as List<dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory About.fromJson(String source) => About.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'About(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(covariant About other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      listEquals(other.description, description);
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;

  factory About.fromMap(Map<String, dynamic> map) {
    return About(
      id: map['id'] as String,
      title: map['title'] as String,
      description: List<dynamic>.from((map['description'] as List<dynamic>)
    ));
  }
}
