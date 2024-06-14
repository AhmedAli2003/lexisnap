import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/constants/app_urls.dart';
import 'package:lexisnap/core/models/api_response.dart';
import 'package:lexisnap/core/models/create_statement_request.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/core/shared/dio_provider.dart';
import 'package:lexisnap/features/home/data/models/statement_model.dart';
import 'package:retrofit/retrofit.dart';

part 'statements_remote_data_source.g.dart';

final statementsRemoteDataSourceProvider = Provider<StatementsRemoteDataSource>(
  (ref) => StatementsRemoteDataSource(
    ref.read(dioProvider),
  ),
);

@RestApi(baseUrl: AppUrls.statementsUrl)
abstract class StatementsRemoteDataSource {
  factory StatementsRemoteDataSource(Dio dio, {String baseUrl}) = _StatementsRemoteDataSource;

  @GET('/{id}')
  Future<ApiResponse<StatementModel>> getStatementById({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
  });

  @POST('/')
  Future<ApiResponse<StatementModel>> createStatement({
    @Header(AppUrls.authorization) required String accessToken,
    @Body() required CreateStatementRequest statement,
  });

  @PATCH('/{id}')
  Future<ApiResponse<StatementModel>> updateStatement({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
    @Body() required UpdateStatementRequest statement,
  });

  @DELETE('/{id}')
  Future<HttpResponse<void>> deleteStatement({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
  });
}
