import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/core/mappers/app_user_model_to_user_model.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:lexisnap/features/auth/data/data_sources/server_auth_data_source.dart';
import 'package:lexisnap/features/auth/data/models/auth_request_body.dart';
import 'package:lexisnap/features/auth/domain/entities/app_user.dart';
import 'package:lexisnap/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref: ref,
    firebaseAuthDataSource: ref.read(firebaseAuthDateSourceProvider),
    serverAuthDataSource: ref.read(serverAuthDataSourceProvider),
  ),
);

class AuthRepositoryImpl implements AuthRepository {
  final Ref _ref;
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  final ServerAuthDataSource _serverAuthDataSource;

  const AuthRepositoryImpl({
    required FirebaseAuthDataSource firebaseAuthDataSource,
    required ServerAuthDataSource serverAuthDataSource,
    required Ref ref,
  })  : _firebaseAuthDataSource = firebaseAuthDataSource,
        _serverAuthDataSource = serverAuthDataSource,
        _ref = ref;

  @override
  Future<Either<Failure, AppUser>> signInWithGoogle() async {
    try {
      final userCredential = await _firebaseAuthDataSource.signInWithGoogle();
      final User? user = userCredential.user;
      if (user == null) {
        throw UnknownFirebaseException();
      }
      if (!user.emailVerified) {
        throw EmailIsNotVerifiedException();
      }
      final idToken = await user.getIdToken();

      if (idToken == null) {
        throw UnknownFirebaseException();
      }

      final authApiResponse = await _serverAuthDataSource.googleSignIn(
        body: AuthRequestBody(idToken),
      );

      if (!authApiResponse.success) {
        throw ServerException(message: authApiResponse.message!);
      }

      if (_ref.read(sharedPrefProvider).getAccessToken() == authApiResponse.accessToken) {
        // Save the access token and the expiration time
        await _ref.read(sharedPrefProvider).saveAccessToken(authApiResponse.accessToken);
        await _ref.read(sharedPrefProvider).saveExpirationDate(authApiResponse.expiresIn);
      }

      return Right(authApiResponse.data!.toDomain());
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      return Right(await _firebaseAuthDataSource.signOut());
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Stream<User?> get authStateChange => _firebaseAuthDataSource.authStateChange;

  @override
  Future<Either<Failure, AppUser>> getUserFromBackend(User user) async {
    try {
      final idToken = await user.getIdToken();

      if (idToken == null) {
        throw UnknownFirebaseException();
      }

      final authApiResponse = await _serverAuthDataSource.googleSignIn(
        body: AuthRequestBody(idToken),
      );

      if (!authApiResponse.success) {
        throw ServerException(message: authApiResponse.message!);
      }

      if (_ref.read(sharedPrefProvider).getAccessToken() == authApiResponse.accessToken) {
        // Save the access token and the expiration time
        await _ref.read(sharedPrefProvider).saveAccessToken(authApiResponse.accessToken);
        await _ref.read(sharedPrefProvider).saveExpirationDate(authApiResponse.expiresIn);
      }

      return Right(authApiResponse.data!.toDomain());
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
