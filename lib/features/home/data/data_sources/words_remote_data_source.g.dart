// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _WordsRemoteDataSource implements WordsRemoteDataSource {
  _WordsRemoteDataSource(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://10.0.0.9:3000/api/v1/words';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<MinimalWordModel>>> getWordsOverview({required String accessToken}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ApiResponse<List<MinimalWordModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/all',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = ApiResponse<List<MinimalWordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json.map<MinimalWordModel>((i) => MinimalWordModel.fromJson(i as Map<String, dynamic>)).toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<PaginationResponse<List<WordModel>>> getAllWords({
    int page = 1,
    required String accessToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<PaginationResponse<List<WordModel>>>(Options(
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
    final value = PaginationResponse<List<WordModel>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json.map<WordModel>((i) => WordModel.fromJson(i as Map<String, dynamic>)).toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ApiResponse<WordModel>> getWordById({
    required String id,
    required String accessToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ApiResponse<WordModel>>(Options(
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
    final value = ApiResponse<WordModel>.fromJson(
      _result.data!,
      (json) => WordModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<WordModel>> createWord({
    required String accessToken,
    required CreateWordRequest word,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(word.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ApiResponse<WordModel>>(Options(
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
    final value = ApiResponse<WordModel>.fromJson(
      _result.data!,
      (json) => WordModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<WordModel>> updateWord({
    required String id,
    required String accessToken,
    required UpdateWordRequest word,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': accessToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(word.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ApiResponse<WordModel>>(Options(
      method: 'PUT',
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
    final value = ApiResponse<WordModel>.fromJson(
      _result.data!,
      (json) => WordModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<HttpResponse<void>> deleteWord({
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
