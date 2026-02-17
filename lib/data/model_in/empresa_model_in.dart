class EmpresaModelIn {
  String nome;
  String fraseEfeito;
  String bs;

  EmpresaModelIn({
    required this.nome,
    required this.fraseEfeito,
    required this.bs,
  });

  factory EmpresaModelIn.fromJson(Map<String, dynamic> json) {
    return EmpresaModelIn(
      nome: json['name'],
      fraseEfeito: json['catchPhrase'],
      bs: json['bs'],
    );
  }

}