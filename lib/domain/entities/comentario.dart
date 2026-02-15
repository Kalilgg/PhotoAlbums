class Comentario {
  int? id;
  String texto;
  String titulo;
  int postId;
  String? emailUsario;

  Comentario({this.id, required this.texto, required this.postId, required this.titulo, this.emailUsario});
}
