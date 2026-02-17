import 'package:photo_album/domain/entities/empresa.dart';
import 'package:photo_album/domain/entities/endereco.dart';

class Autor {
  int id;
  String nome;
  String email;
  Empresa empresa;
  Endereco endereco;


  Autor({
    required this.id,
    required this.nome,
    required this.email,
    required this.empresa,
    required this.endereco,
  });
}