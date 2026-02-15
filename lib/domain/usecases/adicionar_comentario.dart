import 'package:photo_album/data/repositories/comentario_repository.dart';
import 'package:photo_album/domain/entities/comentario.dart';

class AdicionarComentario {
  final ComentarioRepository repository;
  AdicionarComentario(this.repository);

  Future<Comentario> call(Comentario comentario) async {
    return await repository.adicionar(comentario);
  }

}