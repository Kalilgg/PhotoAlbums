class Endereco {
  String rua;
  String complemento;
  String cidade;
  String? estado;
  String cep;
  Localizacao localizacao;


  Endereco({
    required this.rua,
    required this.complemento,
    required this.cidade,
    this.estado,
    required this.cep,
    required this.localizacao,
  });
}

class Localizacao {
  double latitude;
  double longitude;

  Localizacao({
    required this.latitude,
    required this.longitude,
  });
}