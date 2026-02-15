class ComentarioModelOut {
  int postId;
  int? id;
  String name;
  String body;

  ComentarioModelOut({
    this.id,
    required this.postId,
    required this.name,
    required this.body,
  });
  factory ComentarioModelOut.fromJson(Map<String, dynamic> json) {
    return ComentarioModelOut(
      postId: json['postId'],
      name: json['name'],
      body: json['body'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'name': name,
      'body': body,
    };
  }
}