import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/constants/app_urls.dart';
import 'package:lexisnap/core/models/api_response.dart';
import 'package:lexisnap/core/shared/dio_provider.dart';
import 'package:lexisnap/features/contact_us/contact.dart';
import 'package:retrofit/retrofit.dart';

part 'contact_us_data_source.g.dart';

final contactUsDataSourceProvider = Provider<ContactUsDataSource>(
  (ref) => ContactUsDataSource(ref.read(dioProvider)),
);

@RestApi(baseUrl: AppUrls.contactUsUrl)
abstract class ContactUsDataSource {
  factory ContactUsDataSource(Dio dio, {String baseUrl}) = _ContactUsDataSource;

  @POST('/')
  Future<ApiResponse<Contact>> sendContact({
    @Header(AppUrls.authorization) required String accessToken,
    @Body() required Contact contact,
  });
}
