import 'package:photo_album/domain/entities/autor.dart';

abstract class AutorRepository {
  Future<Autor> selecionar(int id);
}