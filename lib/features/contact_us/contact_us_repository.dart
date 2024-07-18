import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/core/shared/internet_checker.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/features/contact_us/contact.dart';
import 'package:lexisnap/features/contact_us/contact_us_data_source.dart';

final contactUsRepositoryProvider = Provider<ContactUsRepository>((ref) {
  return ContactUsRepository(
    dataSource: ref.read(contactUsDataSourceProvider),
    ref: ref,
  );
});

class ContactUsRepository {
  final ContactUsDataSource _dataSource;
  final Ref _ref;

  const ContactUsRepository({
    required ContactUsDataSource dataSource,
    required Ref ref,
  })  : _dataSource = dataSource,
        _ref = ref;

  Future<Either<Failure, Contact>> sendContact(Contact contact) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.sendContact(
        accessToken: accessToken,
        contact: contact,
      );
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!);
    } on NoInternetException {
      return Left(Failure(const NoInternetException()));
    } on ServerException catch (e) {
      return Left(Failure(e));
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
