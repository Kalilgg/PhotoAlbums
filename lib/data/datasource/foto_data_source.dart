import 'package:photo_album/data/model_in/foto_model_in.dart';
import 'package:photo_album/data/model_in/post_model_in.dart';

abstract class FotoDataSource {
  Future<List<FotoModelIn>> listar();
  Future<List<FotoModelIn>> listarFotosPorAlbum(int albumId);
  Future<FotoModelIn> selecionar(int id);
  Future<PostModelIn> selecionarPost(int id);

}