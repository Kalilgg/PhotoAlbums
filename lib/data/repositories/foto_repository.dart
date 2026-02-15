import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/domain/entities/foto.dart';

abstract class FotoRepository {
  Future<List<Foto>> listar();
  Future<List<Foto>> listarFotosPorAlbum(int albumId);
  Future<Foto> selecionar(int id);
  Future<List<Comentario>> listarComentarios(int fotoId);
  Future<Comentario> adicionarComentario(int fotoId, Comentario comentario);
}
