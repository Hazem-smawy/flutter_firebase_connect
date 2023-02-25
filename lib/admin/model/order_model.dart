// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: non_constant_identifier_names
enum OrderStatus { Pending, Recived, Deleverd, Done }

class OrderCompleted extends Equatable {
  final String id;
  final String country;
  final String city;
  final String address; 
  final String image;
  final Order order; 
  final double lang;
  final double long;
  final DateTime completedOn;
  const OrderCompleted({
    required this.id,
    required this.country,
    required this.city,
    required this.address,
    required this.image,
    required this.order,
    required this.lang,
    required this.long,
    required this.completedOn,
  });

  OrderCompleted copyWith({
    String? id,
    String? country,
    String? city,
    String? address,
    String? image,
    Order? order,
    double? lang,
    double? long,
    DateTime? completedOn,
  }) {
    return OrderCompleted(
      id: id ?? this.id,
      country: country ?? this.country,
      city: city ?? this.city,
      address: address ?? this.address,
      image: image ?? this.image,
      order: order ?? this.order,
      lang: lang ?? this.lang,
      long: long ?? this.long,
      completedOn: completedOn ?? this.completedOn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'country': country,
      'city': city,
      'address': address,
      'image': image,
      'order': order.toMap(),
      'lang': lang,
      'long': long,
      'completedOn': completedOn.millisecondsSinceEpoch,
    };
  }

  factory OrderCompleted.fromSnapshot(DocumentSnapshot map) {
    return OrderCompleted(
      id: map['id'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      image: map['image'] as String,
      order: Order.fromMap(map['order'] as Map<String, dynamic>),
      lang: map['lang'],
      long:  map['long'],
      completedOn:
          DateTime.fromMillisecondsSinceEpoch(map['completedOn'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCompleted.fromMap(String source) =>
      OrderCompleted.fromSnapshot(json.decode(source) as DocumentSnapshot);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      country,
      city,
      address,
      image,
      order,
      lang,
      long,
      completedOn,
    ];
  }

  factory OrderCompleted.fromJson(String source) => OrderCompleted.fromSnapshot(json.decode(source) as DocumentSnapshot);

  factory OrderCompleted.fromsna(Map<String, dynamic> map) {
    return OrderCompleted(
      id: map['id'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      image: map['image'] as String,
      order: Order.fromMap(map['order'] as Map<String,dynamic>),
      lang: map['lang'] as double,
      long: map['long'] as double,
      completedOn: DateTime.fromMillisecondsSinceEpoch(map['completedOn'] as int),
    );
  }
}

class Order extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String orderNote;
  final DateTime orderOn;
  final int currencyId;
  final double subtotal;
  final double amountDescount;
  final double totalAbount;
  int status;
  int isCompleted;
  final List<OrderDetails> orderDetails;
  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.orderNote,
    required this.orderOn,
    required this.currencyId,
    required this.subtotal,
    required this.amountDescount,
    required this.totalAbount,
    this.status = 0,
    this.isCompleted = 0,
    required this.orderDetails,
  });

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      customerName,
      orderNote,
      orderOn,
      currencyId,
      subtotal,
      amountDescount,
      totalAbount,
      status,
      isCompleted,
      orderDetails,
    ];
  }

  Order copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? orderNote,
    DateTime? orderOn,
    int? currencyId,
    double? subtotal,
    double? amountDescount,
    double? totalAbount,
    int? status,
    int? isCompleted,
    List<OrderDetails>? orderDetails,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      orderNote: orderNote ?? this.orderNote,
      orderOn: orderOn ?? this.orderOn,
      currencyId: currencyId ?? this.currencyId,
      subtotal: subtotal ?? this.subtotal,
      amountDescount: amountDescount ?? this.amountDescount,
      totalAbount: totalAbount ?? this.totalAbount,
      status: status ?? this.status,
      isCompleted: isCompleted ?? this.isCompleted,
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'orderNote': orderNote,
      'orderOn': orderOn.millisecondsSinceEpoch,
      'currencyId': currencyId,
      'subtotal': subtotal,
      'amountDescount': amountDescount,
      'totalAbount': totalAbount,
      'status': status,
      'isCompleted': isCompleted,
      'orderDetails': orderDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot map) {
    return Order(
      id: map['id'] as String,
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
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

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
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

  // factory Order.fromMap(Map<String, dynamic> map) {
  //   return Order(
  //     id: map['id'] as String,
  //     customerId: map['customerId'] as String,
  //     customerName: map['customerName'] as String,
  //     orderNote: map['orderNote'] as String,
  //     orderOn: DateTime.fromMillisecondsSinceEpoch(map['orderOn'] as int),
  //     currencyId: map['currencyId'] as int,
  //     subtotal: map['subtotal'] as double,
  //     amountDescount: map['amountDescount'] as double,
  //     totalAbount: map['totalAbount'] as double,
  //     status: map['status'] as int,
  //     isCompleted: map['isCompleted'] as int,
  //     orderDetails: List<OrderDetails>.from((map['orderDetails'] as List<int>).map<OrderDetails>((x) => OrderDetails.fromMap(x as Map<String,dynamic>),),),
  //   );
  // }
}

class OrderDetails extends Equatable {
  final int id;
  final String productId;
  int itemQuantity;
  double price;
  final String note;
  OrderDetails({
    required this.id,
    required this.productId,
    this.itemQuantity = 1,
    this.price = 0,
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
    String? productId,
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
      productId: map['productId'] as String,
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
