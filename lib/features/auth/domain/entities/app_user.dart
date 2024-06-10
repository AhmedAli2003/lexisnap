import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class AppUser {
  final String googleId;
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final bool hasExtension;

  const AppUser({
    required this.googleId,
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.hasExtension,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'googleId': googleId,
      '_id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'hasExtension': hasExtension,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      googleId: map['googleId'] as String,
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePicture: map['profilePicture'] as String,
      hasExtension: map['hasExtension'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) {
    return AppUser.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }
}
