class EnderecoModelIn {
  String cep;
  String rua;
  String complemento;
  String cidade;
  LocalizacaoModelIn localizacao;


  EnderecoModelIn({
    required this.cep,
    required this.rua,
    required this.complemento,
    required this.cidade,
    required this.localizacao,
  });

  factory EnderecoModelIn.fromJson(Map<String, dynamic> json) {
    return EnderecoModelIn(
      cep: json['zipcode'],
      rua: json['street'],
      complemento: json['suite'],
      cidade: json['city'],
        localizacao: LocalizacaoModelIn.fromJson(json['geo']),
    );
  }

}

class LocalizacaoModelIn {
  String latitude;
  String longitude;

  LocalizacaoModelIn({
    required this.latitude,
    required this.longitude,
  });
  factory LocalizacaoModelIn.fromJson(Map<String, dynamic> json) {
    return LocalizacaoModelIn(
      latitude: json['lat'],
      longitude: json['lng'],
    );
  }
}