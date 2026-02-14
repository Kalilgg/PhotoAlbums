class FotoModelIn {
  int id;
  String title;
  String url;
  String thumbnailUrl;
  int albumId;

  FotoModelIn({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.albumId,
  });

  factory FotoModelIn.fromJson(Map<String, dynamic> json) {
    return FotoModelIn(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
      albumId: json['albumId'],
    );
  }
}