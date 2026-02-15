import 'package:photo_album/core/network/dio_data_source.dart';
import 'package:photo_album/data/datasource/autor_data_source.dart';
import 'package:photo_album/data/model_in/autor_model_in.dart';

class AutorDataSourceImpl extends DioDataSource implements AutorDataSource {
  AutorDataSourceImpl(super.dio);
  final String _url = '/users';

  @override
  Future<AutorModelIn> selecionar(int id) {
    return get('$_url/$id').then((e) => AutorModelIn.fromJson(e));
  }
}