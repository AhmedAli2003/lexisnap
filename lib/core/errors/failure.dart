// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lexisnap/core/errors/exceptions.dart';

class Failure {
  final String message;
  final int? code;
  Failure(AppException e)
      : message = e.message,
        code = e.code;

  Failure.fromException(Object e)
      : message = e.toString(),
        code = 0;

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
