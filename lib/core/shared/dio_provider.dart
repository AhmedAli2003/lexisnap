import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  // dio.interceptors.add(
  //   RetryInterceptor(
  //     dio: dio,
  //     retries: 3,
  //     retryInterval: const Duration(seconds: 2),
  //   ),
  // );
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  return dio;
});

// class RetryInterceptor extends Interceptor {
//   final Dio dio;
//   final int retries;
//   final Duration retryInterval;

//   RetryInterceptor({
//     required this.dio,
//     this.retries = 3,
//     this.retryInterval = const Duration(seconds: 2),
//   });

//   @override
//   Future onError(DioException  err, ErrorInterceptorHandler handler) async {
//     if (_shouldRetry(err)) {
//       try {
//         return await _retry(err.requestOptions);
//       } catch (e) {
//         return super.onError(err, handler);
//       }
//     }
//     return super.onError(err, handler);
//   }

//   bool _shouldRetry(DioException  err) {
//     return err.type == DioExceptionType.unknown || err.type == DioExceptionType.badResponse;
//   }

//   Future<Response> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );

//     for (int attempt = 1; attempt <= retries; attempt++) {
//       try {
//         return await dio.request(
//           requestOptions.path,
//           options: options,
//           data: requestOptions.data,
//           queryParameters: requestOptions.queryParameters,
//         );
//       } catch (e) {
//         if (attempt == retries) rethrow;
//         await Future.delayed(retryInterval);
//       }
//     }

//     throw DioException(
//       requestOptions: requestOptions,
//       error: 'Max retries reached',
//       type: DioExceptionType.unknown,
//     );
//   }
// }
