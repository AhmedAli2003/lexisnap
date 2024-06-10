import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lexisnap/features/auth/domain/entities/app_user.dart';
import 'package:lexisnap/features/auth/domain/repositories/auth_repository.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';

final userProvider = StateProvider<AppUser?>((ref) => null);

final authStateChangeProvider = StreamProvider<User?>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    ref: ref,
    authRepository: ref.read(authRepositoryProvider),
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final either = await _authRepository.signInWithGoogle();
    state = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (userModel) => _ref.read(userProvider.notifier).update((_) => userModel),
    );
  }

  void signOut(BuildContext context) async {
    state = true;
    final either = await _authRepository.signOut();
    state = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (_) => _ref.read(userProvider.notifier).update((state) => null),
    );
  }

  Future<void> getUserFromBackend(BuildContext context, User user) async {
    state = true;
    final either = await _authRepository.getUserFromBackend(user);
    state = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (userModel) => _ref.read(userProvider.notifier).update((_) => userModel),
    );
  }
}
