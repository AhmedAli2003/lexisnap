import 'package:lexisnap/features/auth/data/models/app_user_model.dart';
import 'package:lexisnap/features/auth/domain/entities/app_user.dart';

extension ToUserModel on AppUserModel {
  AppUser toDomain() => AppUser(
        googleId: googleId,
        id: id,
        name: name,
        email: email,
        profilePicture: profilePicture,
        hasExtension: hasExtension,
      );
}
