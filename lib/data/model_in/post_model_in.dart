class PostModelIn {
  int userId;
  int id;
  String title;
  String body;

  PostModelIn({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModelIn.fromJson(Map<String, dynamic> json) {
    return PostModelIn(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}