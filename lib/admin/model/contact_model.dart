// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String phone;
  final String mobile;
  final String email;
  final String facebook;
  final String whatsapp;
  final String telegram;
  final String instegram;
  final String twitter;
  Contact({
    required this.phone,
    required this.mobile,
    required this.email,
    required this.facebook,
    required this.whatsapp,
    required this.telegram,
    required this.instegram,
    required this.twitter,
  });
  

  Contact copyWith({
    String? phone,
    String? mobile,
    String? email,
    String? facebook,
    String? whatsapp,
    String? telegram,
    String? instegram,
    String? twitter,
  }) {
    return Contact(
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      facebook: facebook ?? this.facebook,
      whatsapp: whatsapp ?? this.whatsapp,
      telegram: telegram ?? this.telegram,
      instegram: instegram ?? this.instegram,
      twitter: twitter ?? this.twitter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'mobile': mobile,
      'email': email,
      'facebook': facebook,
      'whatsapp': whatsapp,
      'telegram': telegram,
      'instegram': instegram,
      'twitter': twitter,
    };
  }

  factory Contact.fromSnapshot(DocumentSnapshot map) {
    return Contact(
      phone: map['phone'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      facebook: map['facebook'] as String,
      whatsapp: map['whatsapp'] as String,
      telegram: map['telegram'] as String,
      instegram: map['instegram'] as String,
      twitter: map['twitter'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromSnapshot(json.decode(source) as DocumentSnapshot);

  @override
  String toString() {
    return 'Contact(phone: $phone, mobile: $mobile, email: $email, facebook: $facebook, whatsapp: $whatsapp, telegram: $telegram, instegram: $instegram, twitter: $twitter)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;
  
    return 
      other.phone == phone &&
      other.mobile == mobile &&
      other.email == email &&
      other.facebook == facebook &&
      other.whatsapp == whatsapp &&
      other.telegram == telegram &&
      other.instegram == instegram &&
      other.twitter == twitter;
  }

  @override
  int get hashCode {
    return phone.hashCode ^
      mobile.hashCode ^
      email.hashCode ^
      facebook.hashCode ^
      whatsapp.hashCode ^
      telegram.hashCode ^
      instegram.hashCode ^
      twitter.hashCode;
  }
}
