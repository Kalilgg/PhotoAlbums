import 'package:photo_album/data/repositories/comentario_repository.dart';
import 'package:photo_album/domain/entities/comentario.dart';

class ListarComentariosFoto {
  final ComentarioRepository repository;
  ListarComentariosFoto(this.repository);

  Future<List<Comentario>> call(int fotoId) async {
    return await repository.listar(fotoId);
  }
}