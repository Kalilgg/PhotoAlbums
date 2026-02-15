import 'package:photo_album/data/model_in/comentario_model_in.dart';
import 'package:photo_album/data/model_out/comentario_model_out.dart';
import 'package:photo_album/domain/entities/comentario.dart';

extension ComentarioConverterApiIn on ComentarioModelIn{
  Comentario toEntity() {
    return Comentario(
      id: this.id, 
      texto: this.body, 
      postId: this.postId, 
      titulo: this.name, 
      emailUsario: this.email,
      );
  }
}

extension ComentarioConverterApiOut on Comentario{
  ComentarioModelOut toModelOut() {
    return ComentarioModelOut(
      postId: this.postId, 
      name: this.titulo, 
      body: this.texto,
      );
  }
}