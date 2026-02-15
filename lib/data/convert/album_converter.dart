import 'package:photo_album/data/model_in/album_model_in.dart';
import 'package:photo_album/domain/entities/album.dart';

extension AlbumConverter on AlbumModelIn {
  Album toEntity() {
    return Album(
      id: this.id,
      nome: this.title,
      autorId: this.userId,
    );
  }
}