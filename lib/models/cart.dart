import 'package:flutter/foundation.dart';

class CartItem {
  final int bookId;
  final String title;
  final int qty;
  final int price;
  final String thumbnailUrl;

  CartItem({
    @required this.bookId,
    @required this.title,
    @required this.qty,
    @required this.price,
    @required this.thumbnailUrl,
  });
}
