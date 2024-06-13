import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/constants/app_urls.dart';
import 'package:lexisnap/core/models/api_response.dart';
import 'package:lexisnap/core/shared/dio_provider.dart';
import 'package:lexisnap/features/home/data/models/minimal_word_model.dart';
import 'package:lexisnap/features/home/data/models/pagination_response.dart';
import 'package:lexisnap/features/home/data/models/word_model.dart';
import 'package:retrofit/retrofit.dart';

part 'words_remote_data_source.g.dart';

final wordsRemoteDataSourceProvider = Provider<WordsRemoteDataSource>(
  (ref) => WordsRemoteDataSource(
    ref.read(dioProvider),
  ),
);

@RestApi(baseUrl: AppUrls.wordsUrl)
abstract class WordsRemoteDataSource {
  factory WordsRemoteDataSource(Dio dio, {String baseUrl}) = _WordsRemoteDataSource;

  @GET('/all')
  Future<ApiResponse<List<MinimalWordModel>>> getWordsOverview({
    @Header(AppUrls.authorization) required String accessToken,
  });

  @GET('/')
  Future<PaginationResponse<List<WordModel>>> getAllWords({
    @Query('page') int page = 1,
    @Header(AppUrls.authorization) required String accessToken,
  });

  @GET('/:id')
  Future<ApiResponse<WordModel>> getWordById({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
  });

  @POST('/')
  Future<ApiResponse<WordModel>> createWord({
    @Header(AppUrls.authorization) required String accessToken,
    @Body() required WordModel word,
  });

  @PUT('/:id')
  Future<ApiResponse<WordModel>> updateWord({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
    @Body() required WordModel word,
  });

  @DELETE('/:id')
  Future<ApiResponse> deleteWord({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
  });
}
