import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioLoggerInterceptor extends Interceptor {
  final logger = Logger(printer: PrettyPrinter());

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';

    logger.d('''
      Request:
      - Path: $requestPath
      - Method: ${options.method}
      - Headers: ${options.headers}
      - Query Params: ${options.queryParameters}
      - Body: ${options.data}
    ''');

    // Call the super class to continue handling the request.
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('''
      Response:
      - Status Code: ${response.statusCode}
      - Headers: ${response.headers}
      - Body: ${response.data}
    ''');

    // Call the super class to continue handling the response.
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('''
      Error:
      - Type: ${err.type}
      - Message: ${err.message}
      - Stack Trace: ${err.stackTrace}
    ''');

    // Call the super class to continue handling the error.
    super.onError(err, handler);
  }
}