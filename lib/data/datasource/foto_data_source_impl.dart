import 'package:photo_album/core/network/dio_data_source.dart';
import 'package:photo_album/data/datasource/foto_data_source.dart';
import 'package:photo_album/data/model_in/foto_model_in.dart';
import 'package:photo_album/data/model_in/post_model_in.dart';

class FotoDataSourceImpl extends DioDataSource implements FotoDataSource {
  FotoDataSourceImpl(super.dio);
  String url = '/photos';

  @override
  Future<List<FotoModelIn>> listar(int comeco, int quantidade) {
    return getAsList(url, queryParameters: {
      '_start': comeco,
      '_limit': quantidade,
    }).then((value) => value.map((e) => FotoModelIn.fromJson(e)).toList());
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

  @override
  Future<PostModelIn> selecionarPost(int id) {
    return get('/posts/$id').then((e) => PostModelIn.fromJson(e));
  }

}