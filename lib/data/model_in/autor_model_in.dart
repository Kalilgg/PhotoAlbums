import 'package:photo_album/data/model_in/empresa_model_in.dart';
import 'package:photo_album/data/model_in/endereco_model_in.dart';

class AutorModelIn {
  int id;
  String name;
  String email;
  EmpresaModelIn empresa;
  EnderecoModelIn endereco;

  AutorModelIn({
    required this.id,
    required this.name,
    required this.email,
    required this.empresa,
    required this.endereco,
  });

  factory AutorModelIn.fromJson(Map<String, dynamic> json) {
    return AutorModelIn(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      empresa: EmpresaModelIn.fromJson(json['company']),
      endereco: EnderecoModelIn.fromJson(json['address']),
      
    );
  }
}