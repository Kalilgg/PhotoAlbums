import 'package:photo_album/data/model_in/autor_model_in.dart';
import 'package:photo_album/domain/entities/autor.dart';

extension AutorConverter on AutorModelIn {
  Autor toEntity() {
    return Autor(
      id: this.id,
      nome: this.name,
      email: this.email,
      empresa: this.empresa,
    );
  }
}