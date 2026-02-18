import 'package:photo_album/data/datasource/dio_data_source.dart';
import 'package:photo_album/data/datasource/comentario_data_source.dart';
import 'package:photo_album/data/model_in/comentario_model_in.dart';
import 'package:photo_album/data/model_out/comentario_model_out.dart';

class ComentarioDataSourceImpl extends DioDataSource implements ComentarioDataSource{
  ComentarioDataSourceImpl(super.dio);

  final String _url = '/comments';
  
  @override
  Future<ComentarioModelIn> adicionar(int fotoId, ComentarioModelOut comentario) {
    return post(_url, data: comentario.toJson()).then((e) => ComentarioModelIn.fromJson(e));
  }

  @override
  Future<List<ComentarioModelIn>> listar(int fotoId) {
    return getAsList(_url, queryParameters: {'postId': fotoId})
      .then((e) => e.map((e) => ComentarioModelIn.fromJson(e)).toList());
  }
  
}