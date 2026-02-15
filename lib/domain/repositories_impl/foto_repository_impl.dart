import 'package:photo_album/data/convert/foto_converter.dart';
import 'package:photo_album/data/datasource/foto_data_source.dart';
import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/domain/entities/foto.dart';
import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/exceptions/repository_exception.dart';

class FotoRepositoryImpl implements FotoRepository {
  FotoDataSource _dataSource;

  FotoRepositoryImpl(this._dataSource);

  @override
  Future<Comentario> adicionarComentario(int fotoId, Comentario comentario) {
    // TODO: implement adicionarComentario
    throw UnimplementedError();
  }

  @override
  Future<List<Foto>> listar() async {
    try {
      final responses = await _dataSource.listar();
      final fotos = responses.map((e) => e.toEntitySemPostEAutor()).toList();
      return fotos;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<List<Comentario>> listarComentarios(int fotoId) async {
    try {
      final responses = await _dataSource.listarComentarios(fotoId);
      final comentarios = responses.map((e) => e.toEntity()).toList();
      return comentarios;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<List<Foto>> listarFotosPorAlbum(int albumId) async {
    try {
      final responses = await _dataSource.listarFotosPorAlbum(albumId);
      final fotos = responses.map((e) => e.toEntitySemPostEAutor()).toList();
      return fotos;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<Foto> selecionar(int id) {
    try {
      final responseFoto = _dataSource.selecionar(id);
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
}
