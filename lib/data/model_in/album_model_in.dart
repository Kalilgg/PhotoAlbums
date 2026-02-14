class AlbumModelIn {
  int userId;
  int id;
  String title;

  AlbumModelIn({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumModelIn.fromJson(Map<String, dynamic> json) {
    return AlbumModelIn(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}