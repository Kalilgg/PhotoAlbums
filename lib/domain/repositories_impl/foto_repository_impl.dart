import 'package:photo_album/data/convert/foto_converter.dart';
import 'package:photo_album/data/datasource/foto_data_source.dart';
import 'package:photo_album/domain/entities/foto.dart';
import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/exceptions/repository_exception.dart';

class FotoRepositoryImpl implements FotoRepository {
  final FotoDataSource _dataSourceFotos;

  FotoRepositoryImpl(this._dataSourceFotos);

  @override
  Future<List<Foto>> listar() async {
    try {
      final responses = await _dataSourceFotos.listar();
      final postResponses = await Future.wait(
        responses.map((foto) => _dataSourceFotos.selecionarPost(foto.id)),
      );
      final fotos = responses
          .map(
            (e) => e.toEntity(
              post: postResponses.where((post) => post.id == e.id).first,
            ),
          )
          .toList();
      return fotos;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<List<Foto>> listarFotosPorAlbum(int albumId) async {
    try {
      final responses = await _dataSourceFotos.listarFotosPorAlbum(albumId);
      final postresponses = await Future.wait(
        responses.map((foto) => _dataSourceFotos.selecionarPost(foto.id)),
      );
      final fotos = responses
          .map(
            (e) => e.toEntity(
              post: postresponses.where((post) => post.id == e.id).first,
            ),
          )
          .toList();
      return fotos;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<Foto> selecionar(int id) async {
    try {
      final responseFoto = await _dataSourceFotos.selecionar(id);
      final responsePost = await _dataSourceFotos.selecionarPost(id);
      final foto = responseFoto.toEntity(post: responsePost);
      return foto;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
}
