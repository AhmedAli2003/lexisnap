import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetChecker {
  const InternetChecker();

  Future<bool> get hasConnection;
}

final internetCheckerProvider = Provider<InternetChecker>(
  (ref) => InternetCheckerImpl(
    InternetConnectionChecker(),
  ),
);

class InternetCheckerImpl extends InternetChecker {
  final InternetConnectionChecker checker;

  const InternetCheckerImpl(this.checker);

  @override
  Future<bool> get hasConnection => checker.hasConnection;
}
