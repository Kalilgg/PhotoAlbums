import 'package:photo_album/data/models/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> listarPorAutor(int autorId);
  Future<Album> selecionar(int id);
}