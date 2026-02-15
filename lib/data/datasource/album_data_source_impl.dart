import 'package:photo_album/core/network/dio_data_source.dart';
import 'package:photo_album/data/datasource/album_data_source.dart';
import 'package:photo_album/data/model_in/album_model_in.dart';

class AlbumDataSourceImpl extends DioDataSource implements AlbumDataSource{
  
  AlbumDataSourceImpl(super.dio);
  String _url = '/albums';
  
  @override
  Future<List<AlbumModelIn>> listarPorAutor(int autorId) {
    return getAsList('users/$autorId/$_url')
    .then((value) => value.map((e) => AlbumModelIn.fromJson(e)).toList());
  }

  @override
  Future<AlbumModelIn> selecionar(int id) {
    return get('$_url/$id').then((e) => AlbumModelIn.fromJson(e));
  }
}