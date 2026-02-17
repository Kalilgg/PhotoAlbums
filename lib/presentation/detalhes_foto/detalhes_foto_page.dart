import 'package:flutter/material.dart';
import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/presentation/envio_comentario/comentario_controller.dart';
import 'package:photo_album/presentation/envio_comentario/envio_comentario_page.dart';
import 'package:photo_album/presentation/detalhes_foto/foto_controller.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';
import 'package:photo_album/domain/entities/foto.dart';

class DetalheFotoPage extends StatelessWidget {
  final Foto foto;

  const DetalheFotoPage(this.foto, {super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FotoController>().carregarConteudo(foto.id);
      context.read<ComentarioController>().carregarComentarios(foto.id);
    });

    final controller = context.read<FotoController>();
    final comentarioController = context.read<ComentarioController>();

    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        title: const Text(
          "Detalhes da Foto",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackButton(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'foto_${foto.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                            maxHeight: 120,
                          ),
                          child: Image.network(
                            foto.imgGrande,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120,
                                height: 120,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foto.titulo,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Watch((_) {
                            final album = controller.album.value;
                            final autor = controller.autor.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(
                                  Icons.photo_album, 
                                  album?.nome ?? 'Carregando...'
                                ),
                                const SizedBox(height: 4),
                                _buildInfoRow(
                                  Icons.person, 
                                  autor?.nome ?? 'Carregando...'
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () { /* Lógica do mapa */ },
                      icon: const Icon(Icons.map, size: 18),
                      label: const Text("Ver no mapa", style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () { /* Lógica de email */ },
                      icon: const Icon(Icons.email, size: 18),
                      label: const Text("Enviar email", style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnvioComentarioPage(fotoId: foto.id),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add_comment_outlined, color: Colors.blue, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Divider(thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text(
                    "Descrição",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    foto.descricao,
                    style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
             const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Divider(thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Comentários",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Watch((_) {
                    final isLoading = comentarioController.isLoadingComentarios.value;
                    List<Comentario> comentarios = controller.comentarios.value;
                    if (isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (comentarios.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Text(
                          "Nenhum comentário ainda.",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      );
                    }
                    return Column(
                      children: comentarios.map((comentario) {
                        return _buildComentarioItem(comentario);
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildComentarioItem(Comentario comentario) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blue[100],
                  child: Text(
                    comentario.emailUsario?.characters.first.toUpperCase() ?? 'A',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comentario.emailUsario ?? 'Anônimo',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                       Text(
                        comentario.titulo,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              comentario.texto,
              style: TextStyle(color: Colors.grey[800], height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}