import 'package:flutter/foundation.dart';

class OrderItem {
  final int orderId;
  final String name;
  final String address;
  final int total;

  OrderItem({
    @required this.orderId,
    @required this.name,
    @required this.address,
    @required this.total,
  });

  factory OrderItem.fromJson(dynamic json) {
    return OrderItem(
        orderId: json['orderId'] as int,
        name: json['name'] as String,
        address: json['address'] as String,
        total: json['total'] as int);
  }

  @override
  String toString() {
    return '{ ${this.orderId}, ${this.name}, ${this.address} , ${this.total} }';
  }
}
