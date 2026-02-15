import 'package:photo_album/domain/entities/foto.dart';

abstract class FotoRepository {
  Future<List<Foto>> listar();
  Future<List<Foto>> listarFotosPorAlbum(int albumId);
  Future<Foto> selecionar(int id);
}
