// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: non_constant_identifier_names
enum OrderStatus { Pending, Recived, Deleverd, Done }

class Order extends Equatable {
  final int id;
  final String customerId;
  final String orderNote;
  final DateTime orderOn;
  final int currencyId;
  final double subtotal;
  final double amountDescount;
  final double totalAbount;
  int status;
  final List<OrderDetails> orderDetails;
  Order({
    required this.id,
    required this.customerId,
    required this.orderNote,
    required this.orderOn,
    required this.currencyId,
    required this.subtotal,
    required this.amountDescount,
    required this.totalAbount,
    this.status = 1,
    required this.orderDetails,
  });

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      orderNote,
      orderOn,
      currencyId,
      subtotal,
      amountDescount,
      totalAbount,
      status,
      orderDetails,
    ];
  }

  Order copyWith({
    int? id,
    String? customerId,
    String? orderNote,
    DateTime? orderOn,
    int? currencyId,
    double? subtotal,
    double? amountDescount,
    double? totalAbount,
    int? status,
    List<OrderDetails>? orderDetails,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      orderNote: orderNote ?? this.orderNote,
      orderOn: orderOn ?? this.orderOn,
      currencyId: currencyId ?? this.currencyId,
      subtotal: subtotal ?? this.subtotal,
      amountDescount: amountDescount ?? this.amountDescount,
      totalAbount: totalAbount ?? this.totalAbount,
      status: status ?? this.status,
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerId': customerId,
      'orderNote': orderNote,
      'orderOn': orderOn.millisecondsSinceEpoch,
      'currencyId': currencyId,
      'subtotal': subtotal,
      'amountDescount': amountDescount,
      'totalAbount': totalAbount,
      'status': status,
      'orderDetails': orderDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot map) {
    return Order(
      id: map['id'] as int,
      customerId: map['customerId'] as String,
      orderNote: map['orderNote'] as String,
      orderOn: DateTime.fromMillisecondsSinceEpoch(map['orderOn'] as int),
      currencyId: map['currencyId'] as int,
      subtotal: map['subtotal'] as double,
      amountDescount: map['amountDescount'] as double,
      totalAbount: map['totalAbount'] as double,
      status: map['status'] as int,
      orderDetails: List<OrderDetails>.from(
        (map['orderDetails'] as List<dynamic>).map<OrderDetails>(
          (x) => OrderDetails.fromSnapshot(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromSnapshot(json.decode(source) as DocumentSnapshot);

  @override
  bool get stringify => true;
}

class OrderDetails extends Equatable {
  final int id;
  final int productId;
  final int itemQuantity;
  final double price;
  final String note;
  const OrderDetails({
    required this.id,
    required this.productId,
    required this.itemQuantity,
    required this.price,
    required this.note,
  });

  @override
  List<Object> get props {
    return [
      id,
      productId,
      itemQuantity,
      price,
      note,
    ];
  }

  OrderDetails copyWith({
    int? id,
    int? productId,
    int? itemQuantity,
    double? price,
    String? note,
  }) {
    return OrderDetails(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      price: price ?? this.price,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'itemQuantity': itemQuantity,
      'price': price,
      'note': note,
    };
  }

  factory OrderDetails.fromSnapshot(Map<String, dynamic> map) {
    return OrderDetails(
      id: map['id'] as int,
      productId: map['productId'] as int,
      itemQuantity: map['itemQuantity'] as int,
      price: map['price'] as double,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetails.fromJson(String source) =>
      OrderDetails.fromSnapshot(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
