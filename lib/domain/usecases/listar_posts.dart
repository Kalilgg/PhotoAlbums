import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/entities/foto.dart';

class ListarPosts {
  final FotoRepository repository;
  ListarPosts(this.repository);

  Future<List<Foto>> call() async {
    return await repository.listar();
  }
}
