import 'package:photo_album/data/convert/album_converter.dart';
import 'package:photo_album/data/datasource/album_data_source.dart';
import 'package:photo_album/data/repositories/album_repository.dart';
import 'package:photo_album/domain/entities/album.dart';
import 'package:photo_album/domain/exceptions/repository_exception.dart';

class AlbumRepositoryImpl implements AlbumRepository{
  final AlbumDataSource _dataSource;
  AlbumRepositoryImpl(this._dataSource);


  @override
  Future<List<Album>> listarPorAutor(int autorId) async {
    try {
      final response = await _dataSource.listarPorAutor(autorId);
      final album = response.map((e) => e.toEntity()).toList();
      return album;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<Album> selecionar(int id) async {
    try {
      final response = await _dataSource.selecionar(id);
      final album = response.toEntity();
      return album;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
}