import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//Import DotEnv
import 'package:flutter_dotenv/flutter_dotenv.dart ' as DotEnv;
//Import SharedPref
import 'package:shared_preferences/shared_preferences.dart';
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
    String url = DotEnv.env['api_url'] + 'books';
    //Get Token from SharePref
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      "Authorization": "bearer $token"
    };

    http
        .get(
      url, //Edit url
      headers: headers,
    )
        .then((response) {
      if (response.statusCode == 200) {
        //Code for status 200
        _items = List<Book>.from(
            jsonDecode(response.body)['data'].map((bk) => Book.fromJson(bk)));
        notifyListeners();
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
