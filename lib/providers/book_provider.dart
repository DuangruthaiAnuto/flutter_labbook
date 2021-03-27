import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//Import DotEnv
//Import SharedPref
import '../models/book.dart';

class Books with ChangeNotifier {
  List<Book> _items = [];

  List<Book> get items {
    if (_items.isEmpty) {
      loadBooks();
    }

    return _items;
  }

  void loadBooks() async {
    //Get API URL from .env
    //Get Token from SharePref
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      //Authorize Header
    };

    http
        .get(
      'edit url', //Edit url
      headers: headers,
    )
        .then((response) {
      if (response.statusCode == 200) {
        //Code for status 200

      } else {
        throw Exception('Failed to load books');
      }
    });
  }

  Book findByBookId(int bookId) {
    return _items.firstWhere((bk) => bk.bookId == bookId);
  }

  List<Book> findBookTitle(String searchTitle) {
    return _items
        .where(
            (bk) => bk.title.toLowerCase().contains(searchTitle.toLowerCase()))
        .toList();
  }
}
