abstract class ComentarioRepository {
  Future<List<String>> listar(int fotoId);
  Future<String> adicionar(int fotoId);
}