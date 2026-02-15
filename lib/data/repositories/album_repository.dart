import 'package:photo_album/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> listarPorAutor(int autorId);
  Future<Album> selecionar(int id);
}