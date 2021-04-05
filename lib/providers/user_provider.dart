import 'dart:convert';
import 'package:http/http.dart' as http;
//Import DotEnv
import 'package:flutter_dotenv/flutter_dotenv.dart ' as DotEnv;
//Import SharedPref
import 'package:shared_preferences/shared_preferences.dart';

class User {
  Future<void> signIn(username, password) {
    //Get API URL from .env
    String url = DotEnv.env['api_url'] + 'auth/signin';
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Content-type": "application/json",
    };

    http
        .post(
      url, //edit url
      headers: headers,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    )
        .then((response) async {
      //Code response
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 201) {
        String token = jsonDecode(response.body)['accessToken'];
        int userId = jsonDecode(response.body)['userId'];

        prefs.setInt('userId', userId);
        prefs.setString('username', username);
        prefs.setString('token', token);
      } else {
        prefs.setInt('userId', null);
        prefs.setString('username', null);
        prefs.setString('token', null);
      }
    });
    //return 0;
  }
}
