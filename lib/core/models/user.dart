import 'package:flutter/material.dart';

class User {
  final String email;
  final String userName;

  const User({
    @required this.email,
    @required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['email'] = email;
    data['userName'] = userName;

    return data;
  }
}
