import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/dio_provider.dart';
import 'package:lexisnap/features/auth/data/models/auth_api_response.dart';
import 'package:lexisnap/features/auth/data/models/auth_request_body.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lexisnap/core/constants/app_urls.dart';
import 'package:lexisnap/features/auth/data/models/app_user_model.dart';

part 'server_auth_data_source.g.dart';

final serverAuthDataSourceProvider = Provider<ServerAuthDataSource>(
  (ref) => ServerAuthDataSource(ref.read(dioProvider)),
);

@RestApi(baseUrl: AppUrls.authUrl)
abstract class ServerAuthDataSource {
  factory ServerAuthDataSource(Dio dio, {String baseUrl}) = _ServerAuthDataSource;

  @POST('/google-sign-in')
  Future<AuthApiResponse<AppUserModel>> googleSignIn({
    @Body() required AuthRequestBody body,
  });
}
