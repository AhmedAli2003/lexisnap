import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<Either<Failure, AppUser>> signInWithGoogle();
  Future<Either<Failure, AppUser>> getUserFromBackend(User user);
  Future<Either<Failure, Unit>> signOut();
  Stream<User?> get authStateChange;
}
