import 'package:photo_album/core/network/dio_data_source.dart';
import 'package:photo_album/data/datasource/foto_data_source.dart';
import 'package:photo_album/data/model_in/comentario_model_in.dart';
import 'package:photo_album/data/model_in/foto_model_in.dart';

class FotoDataSourceImpl extends DioDataSource implements FotoDataSource {
  FotoDataSourceImpl(super.dio);
  String url = '/photos';

  @override
  Future<ComentarioModelIn> adicionarComentario(int fotoId, ComentarioModelOut comentario) {
    //TODO: implement adicionarComentario
    throw UnimplementedError();
  }

  @override
  Future<List<FotoModelIn>> listar() {
    return getAsList(url).then((value) 
    => value.map((e) => FotoModelIn.fromJson(e)).toList());
  }

  @override
  Future<List<ComentarioModelIn>> listarComentarios(int fotoId) {
    return getAsList('$url/posts/$fotoId/comments')
    .then((e) => e.map((e) => ComentarioModelIn.fromJson(e)).toList());
  }

  @override
  Future<List<FotoModelIn>> listarFotosPorAlbum(int albumId) {
    return getAsList('/albums/$albumId/photos').then((value) 
    => value.map((e) => FotoModelIn.fromJson(e)).toList());
  }

  @override
  Future<FotoModelIn> selecionar(int id) {
    return get('$url/$id').then((e) => FotoModelIn.fromJson(e));
  }

}