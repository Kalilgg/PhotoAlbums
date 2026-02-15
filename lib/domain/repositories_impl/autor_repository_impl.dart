import 'package:photo_album/data/convert/autor_converter.dart';
import 'package:photo_album/data/datasource/autor_data_source.dart';
import 'package:photo_album/data/repositories/autor_repository.dart';
import 'package:photo_album/domain/entities/autor.dart';
import 'package:photo_album/domain/exceptions/repository_exception.dart';

class AutorRepositoryImpl implements AutorRepository {
  final AutorDataSource _dataSource;
  AutorRepositoryImpl(this._dataSource);

  @override
  Future<Autor> selecionar(int id) async {
    try {
      final response = await _dataSource.selecionar(id);
      return response.toEntity(); 
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }
}
