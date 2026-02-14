import 'package:dio/dio.dart';

class RepositoryException implements Exception {
  final String? message;

  RepositoryException(this.message);

  factory RepositoryException.fromDioException(DioException dioException) {
    if (dioException.response != null) {
      return RepositoryException('erro ${dioException.response?.statusCode?.toString()}');
    } else if (dioException.error != null) {
      if (dioException.error is FormatException) {
        return RepositoryException((dioException.error as FormatException).source);
      }
      return RepositoryException(dioException.error.toString());
    } else {
      return RepositoryException(null);
    }
  }

  @override
  String toString() => message ?? 'Erro ao realizar operação no repositório';
}