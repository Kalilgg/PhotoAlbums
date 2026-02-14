class AutorModelIn {
  int id;
  String name;
  String email;

  AutorModelIn({
    required this.id,
    required this.name,
    required this.email,
   });

  factory AutorModelIn.fromJson(Map<String, dynamic> json) {
    return AutorModelIn(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

}
