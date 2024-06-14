import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/constants/app_urls.dart';
import 'package:lexisnap/core/models/api_response.dart';
import 'package:lexisnap/core/shared/dio_provider.dart';
import 'package:lexisnap/features/home/data/models/minimal_tag_model.dart';
import 'package:lexisnap/features/home/data/models/pagination_response.dart';
import 'package:lexisnap/features/home/data/models/tag_model.dart';
import 'package:lexisnap/core/models/create_or_update_tag_request.dart';
import 'package:retrofit/retrofit.dart';

part 'tags_remote_data_source.g.dart';

final tagsRemoteDataSourceProvider = Provider<TagsRemoteDataSource>(
  (ref) => TagsRemoteDataSource(
    ref.read(dioProvider),
  ),
);

@RestApi(baseUrl: AppUrls.tagsUrl)
abstract class TagsRemoteDataSource {
  factory TagsRemoteDataSource(Dio dio, {String baseUrl}) = _TagsRemoteDataSource;

  @GET('/')
  Future<PaginationResponse<List<MinimalTagModel>>> getAllTags({
    @Query('page') int page = 1,
    @Header(AppUrls.authorization) required String accessToken,
  });

  @GET('/:id')
  Future<ApiResponse<TagModel>> getTagById({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
  });

  @POST('/')
  Future<ApiResponse<TagModel>> createTag({
    @Header(AppUrls.authorization) required String accessToken,
    @Body() required CreateOrUpdateTagRequest tag,
  });

  @PATCH('/:id')
  Future<ApiResponse<MinimalTagModel>> updateTag({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
    @Body() required CreateOrUpdateTagRequest tag,
  });

  @DELETE('/:id')
  Future<ApiResponse> deleteTag({
    @Path('id') required String id,
    @Header(AppUrls.authorization) required String accessToken,
  });
}
