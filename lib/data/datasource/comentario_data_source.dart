import 'package:photo_album/data/model_in/comentario_model_in.dart';
import 'package:photo_album/data/model_out/comentario_model_out.dart';

abstract class ComentarioDataSource {
  Future<List<ComentarioModelIn>> listar(int fotoId);
  Future<ComentarioModelIn> adicionar(int fotoId, ComentarioModelOut comentario);
}