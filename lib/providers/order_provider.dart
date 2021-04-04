import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//Import DotEnv
import 'package:flutter_dotenv/flutter_dotenv.dart ' as DotEnv;
//Import SharedPref
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return _orders;
  }

  void loadOrderbyId() async {
    //Get API URL from .env
    //Get Token from SharePref
    //Get userId from SharePref
    String url = DotEnv.env['api_url'] + 'order/:userId';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
      //Authorize Header
    };

    http
        .get(
      url, //edit url
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
}
