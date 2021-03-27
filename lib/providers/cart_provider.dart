import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//Import DotEnv
//Import SharedPref
import '../models/cart.dart';

class Cart with ChangeNotifier {
  Map<int, CartItem> _items = {};

  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qty;
    });
    return total;
  }

  String toJson() {
    String jsonString = ""; //json.encode(_items);

    if (_items.length > 0) {
      _items.forEach((key, item) {
        String jsonStringItem = '''
      {
        "bookId": ${item.bookId},
        "price": ${item.price},
        "qty": ${item.qty}
      },''';
        jsonString = jsonString + jsonStringItem;
      });
      jsonString = "[" + jsonString.substring(0, jsonString.length - 1) + "]";
    }

    return jsonString;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void addItem(
    int bookId,
    int price,
    String title,
    String thumbnailUrl,
    int qty,
  ) {
    if (_items.containsKey(bookId)) {
      _items.update(
        bookId,
        (existingCartItem) => CartItem(
          bookId: existingCartItem.bookId,
          title: existingCartItem.title,
          price: existingCartItem.price,
          qty: qty,
          thumbnailUrl: existingCartItem.thumbnailUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        bookId,
        () => CartItem(
          bookId: bookId,
          title: title,
          price: price,
          qty: qty,
          thumbnailUrl: thumbnailUrl,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(int bookId) {
    _items.remove(bookId);
    notifyListeners();
  }

  void increaseItem(int bookId) {
    _items.update(
      bookId,
      (existingCartItem) => CartItem(
        bookId: existingCartItem.bookId,
        title: existingCartItem.title,
        price: existingCartItem.price,
        qty: existingCartItem.qty + 1,
        thumbnailUrl: existingCartItem.thumbnailUrl,
      ),
    );
    notifyListeners();
  }

  void decreaseItem(int bookId) {
    _items.update(
      bookId,
      (existingCartItem) => CartItem(
        bookId: existingCartItem.bookId,
        title: existingCartItem.title,
        price: existingCartItem.price,
        qty: (existingCartItem.qty > 1)
            ? existingCartItem.qty - 1
            : existingCartItem.qty,
        thumbnailUrl: existingCartItem.thumbnailUrl,
      ),
    );
    notifyListeners();
  }

  void addOrder(name, address) async {
    //Get API URL from .env
    //Get Token from SharePref
    //Get userId from SharePref

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      //Authorize Header
    };
    http
        .post(
      'url', //Edit url
      headers: headers,
      body: json.encode({
        'userId': 'userId', //Edit userId
        'name': name,
        'address': address,
        'total': totalAmount,
        //code detail
      }),
    )
        .then((response) {
      clearCart();
    });
  }
}
