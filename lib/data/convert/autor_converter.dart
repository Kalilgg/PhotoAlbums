import 'package:photo_album/data/model_in/autor_model_in.dart';
import 'package:photo_album/domain/entities/autor.dart';
import 'package:photo_album/domain/entities/empresa.dart';
import 'package:photo_album/domain/entities/endereco.dart';

extension AutorConverter on AutorModelIn {
  Autor toEntity() {
    return Autor(
      id: this.id,
      nome: this.name,
      email: this.email,
      empresa: Empresa(
        nome: empresa.nome, 
        fraseEfeito: empresa.fraseEfeito, 
        bs: empresa.bs,
        ),
      endereco: Endereco(
        rua: endereco.rua, 
        complemento: endereco.complemento, 
        cidade: endereco.cidade, 
        cep: endereco.cep, 
        localizacao: Localizacao(
          latitude: endereco.localizacao.latitude, 
          longitude: endereco.localizacao.longitude,
          ),
          ),
    );
  }
}