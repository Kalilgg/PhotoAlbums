
import 'package:photo_album/data/model_in/autor_model_in.dart';
import 'package:photo_album/data/model_in/foto_model_in.dart';
import 'package:photo_album/data/model_in/post_model_in.dart';
import 'package:photo_album/domain/entities/foto.dart';

extension FotoConverter on FotoModelIn {
  Foto toEntity({
    required PostModelIn post, 
    required AutorModelIn autor,
  }) {
    return Foto(
      id: this.id,
      titulo: this.title,
      descricao: post.body, 
      albumId: this.albumId,
      autorId: autor.id,
      imgGrande: this.url,
      imgPequena: this.thumbnailUrl,
    );
  }

  Foto toEntitySemPostEAutor() {
    return Foto(
      id: this.id,
      titulo: this.title,
      albumId: this.albumId,
      imgGrande: this.url,
      imgPequena: this.thumbnailUrl,
    );
  }

}