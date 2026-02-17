class AppExternoException implements Exception {
  final String? message;

  AppExternoException(this.message);

  @override
  String toString() => message ?? 'Erro ao abrir aplicativo externo';
}