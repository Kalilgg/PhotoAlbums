import 'package:photo_album/data/model_in/album_model_in.dart';

abstract class AlbumDataSource {
  Future<List<AlbumModelIn>> listarPorAutor(int autorId);
  Future<AlbumModelIn> selecionar(int id);
}