class AutorModelIn {
  int id;
  String name;
  String email;
  String empresa;

  AutorModelIn({
    required this.id,
    required this.name,
    required this.email,
    required this.empresa,
  });

  factory AutorModelIn.fromJson(Map<String, dynamic> json) {
    return AutorModelIn(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      empresa: json['company']['name'], 
    );
  }
}