import 'package:photo_album/data/convert/comentario_converter.dart';
import 'package:photo_album/data/datasource/comentario_data_source.dart';
import 'package:photo_album/data/repositories/comentario_repository.dart';
import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/domain/exceptions/repository_exception.dart';

class ComentarioRepositoryImpl implements ComentarioRepository {
  final ComentarioDataSource _dataSource;
  ComentarioRepositoryImpl(this._dataSource);

  @override
  Future<Comentario> adicionar(Comentario comentario) async {
    try {
      final modelOut = comentario.toModelOut();
      final response = await _dataSource
          .adicionar(comentario.postId, modelOut)
          .then((e) => e.toEntity());
      return response;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<List<Comentario>> listar(int fotoId) async{
    try {
      final responses = await _dataSource.listar(fotoId);
      final comentarios = responses.map((e) => e.toEntity()).toList();
      return comentarios;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
}
