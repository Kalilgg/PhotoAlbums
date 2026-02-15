import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/entities/foto.dart';

class MostarDetalhesImagem {
  final FotoRepository repository;
  MostarDetalhesImagem(this.repository);

  Future<Foto> call(int id) async {
    return await repository.selecionar(id);
  }

}