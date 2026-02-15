class ComentarioModelIn {
  int postId;
  int id;
  String name;
  String body;
  String email;

  ComentarioModelIn({
    required this.postId,
    required this.id,
    required this.name,
    required this.body,
    required this.email,
  });
  factory ComentarioModelIn.fromJson(Map<String, dynamic> json) {
    return ComentarioModelIn(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      body: json['body'],
      email: json['email'],
    );
  }
}