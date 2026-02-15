import 'package:photo_album/data/model_in/autor_model_in.dart';

abstract class AutorDataSource {
  Future<AutorModelIn> selecionar(int id);
}