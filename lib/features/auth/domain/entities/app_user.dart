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
}
