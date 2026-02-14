import 'dart:io';

import 'package:dio/dio.dart';

class DataSourceException implements Exception {
  final int? statusCode;
  final String? message;

  DataSourceException(this.message, {this.statusCode});

  factory DataSourceException.fromDioException(DioException dioException) {
    if (dioException.response != null) {
      if (dioException.response?.statusCode == 500) {
        return DataSourceException('Erro interno no servidor.',
            statusCode: 500);
      } else if (dioException.response?.statusCode == 400) {
        return DataSourceException(_extractPossibleErrorsFields(dioException),
            statusCode: 400);
      } else if (dioException.response?.statusCode == 404) {
        final data = dioException.response?.data;
        if (data != null && data is Map) {
          final map = data as Map<String, dynamic>;
          if (map['mensagem'] != null) {
            return DataSourceException('Erro 404 - ${map['mensagem']}',
                statusCode: 404);
          }
        }
        return DataSourceException(
            'Erro 404 - Recurso não encontrado.\n'
            'Verifique se o sistema está atualizado e respondendo no endereço ${dioException.requestOptions.baseUrl}',
            statusCode: 404);
      } else if (dioException.response?.statusCode == 403) {
        return DataSourceException(dioException.response?.data.toString(),
            statusCode: 403);
      } else if (dioException.response?.statusCode == 409) {
        return DataSourceException(dioException.response?.data.toString(),
            statusCode: 409);
      } else if (dioException.response?.statusCode == 422) {
        final data = dioException.response?.data;
        final map = data as Map<String, dynamic>;
        return DataSourceException('${map['mensagem']}', statusCode: 422);
      }
      return DataSourceException(
        'Erro ${dioException.response?.statusCode?.toString()}\n${dioException.response?.data.toString()}',
        statusCode: dioException.response?.statusCode,
      );
    } else if (dioException.error != null) {
      if (dioException.error is FormatException) {
        return DataSourceException(
          (dioException.error as FormatException).source,
          statusCode: dioException.response?.statusCode,
        );
      } else if (dioException.error is SocketException) {
        return DataSourceException(
          'Erro de conexão: ${(dioException.error as SocketException).message}\n'
          'Verifique sua conexão com a internet.',
          statusCode: dioException.response?.statusCode,
        );
      }
      return DataSourceException(
        dioException.error.toString(),
        statusCode: dioException.response?.statusCode,
      );
    } else if (dioException.type == DioExceptionType.connectionTimeout) {
      return DataSourceException(
        'Tempo de conexão excedido. Verifique sua conexão com a internet.',
        statusCode: dioException.response?.statusCode,
      );
    } else if (dioException.type == DioExceptionType.receiveTimeout) {
      return DataSourceException(
        'Tempo de resposta excedido. Verifique sua conexão com a internet.',
        statusCode: dioException.response?.statusCode,
      );
    } else if (dioException.type == DioExceptionType.sendTimeout) {
      return DataSourceException(
        'Tempo de envio excedido. Verifique sua conexão com a internet.',
        statusCode: dioException.response?.statusCode,
      );
    } else {
      return DataSourceException(null);
    }
  }

  static String _extractPossibleErrorsFields(DioException dioException) {
    final data = dioException.response?.data;
    const defaultMessage = 'Erro 400 - Requisição inválida.\n';

    if (data == null) {
      return defaultMessage;
    }
    if (data is Map == false) {
      return defaultMessage;
    }

    try {
      final map = data as Map;
      List errors = map['errors'];
      final messages = errors.map((e) => e['message']).toList();
      return messages.join('\n');
    } catch (_) {
      return defaultMessage;
    }
  }

  @override
  String toString() => message ?? 'Erro ao realizar operação no repositório';
}