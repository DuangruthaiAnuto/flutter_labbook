import 'package:flutter/foundation.dart';

class UserModel {
  final int userId;
  final String username;
  final String token;

  UserModel({
    @required this.userId,
    @required this.username,
    @required this.token,
  });
}
