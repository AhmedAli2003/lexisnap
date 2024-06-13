class AppException implements Exception {
  final String message;
  final int? code;

  const AppException({
    required this.message,
    this.code,
  });
}

class ServerException extends AppException {
  const ServerException({required super.message, super.code});
}

class NoChosenGoogleAccountException extends AppException {
  const NoChosenGoogleAccountException({
    super.message = 'Choose an account to continue',
    super.code,
  });
}

class EmailIsNotVerifiedException extends AppException {
  EmailIsNotVerifiedException({
    super.message = 'Email is not verified!',
    super.code,
  });
}

class UnknownFirebaseException extends AppException {
  UnknownFirebaseException({
    super.message = 'Some error occured, try again later',
    super.code,
  });
}

class CouldNotMappingException extends AppException {
  const CouldNotMappingException({required super.message});
}
