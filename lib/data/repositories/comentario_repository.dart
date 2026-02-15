import 'package:photo_album/domain/entities/comentario.dart';

abstract class ComentarioRepository {
  Future<List<Comentario>> listar(int fotoId);
  Future<Comentario> adicionar(Comentario comentario);
}