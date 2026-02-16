class Foto {
  int id; //Considerada id do post para relacionar com os comentários.
  String titulo;
  String descricao;//descrição que vem do post
  int albumId;//vem do album
  int autorId;
  String imgGrande;
  String imgPequena;

  Foto({required this.id, required this.titulo, required this.descricao, required this.albumId, required this.autorId, required this.imgGrande, required this.imgPequena});
}
