// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _TagsRemoteDataSource implements TagsRemoteDataSource {
  _TagsRemoteDataSource(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://10.0.0.9:3000/api/v1/tags';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PaginationResponse<List<MinimalTagModel>>> getAllTags({
    int page = 1,
    required String accessToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<PaginationResponse<List<MinimalTagModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PaginationResponse<List<MinimalTagModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json.map<MinimalTagModel>((i) => MinimalTagModel.fromJson(i as Map<String, dynamic>)).toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ApiResponse<TagModel>> getTagById({
    required String id,
    required String accessToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ApiResponse<TagModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = ApiResponse<TagModel>.fromJson(
      _result.data!,
      (json) => TagModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<TagModel>> createTag({
    required String accessToken,
    required CreateOrUpdateTagRequest tag,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(tag.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ApiResponse<TagModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = ApiResponse<TagModel>.fromJson(
      _result.data!,
      (json) => TagModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<MinimalTagModel>> updateTag({
    required String id,
    required String accessToken,
    required CreateOrUpdateTagRequest tag,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(tag.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ApiResponse<MinimalTagModel>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = ApiResponse<MinimalTagModel>.fromJson(
      _result.data!,
      (json) => MinimalTagModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<HttpResponse<void>> deleteTag({
    required String id,
    required String accessToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<void>(_setStreamType<HttpResponse<void>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final httpResponse = HttpResponse(null, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
