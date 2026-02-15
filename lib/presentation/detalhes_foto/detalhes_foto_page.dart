import 'package:flutter/material.dart';
import 'package:photo_album/presentation/envio_comentario/envio_comentario_page.dart';
import 'package:photo_album/presentation/main_page/foto_controller.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';
import 'package:photo_album/domain/entities/foto.dart';

class DetalheFotoPage extends StatefulWidget {
  final Foto foto;

  const DetalheFotoPage({super.key, required this.foto});

  @override
  State<DetalheFotoPage> createState() => _DetalheFotoPageState();
}

class _DetalheFotoPageState extends State<DetalheFotoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FotoController>().carregarComentarios(widget.foto.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FotoController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'foto_${widget.foto.id}',
                child: Image.network(widget.foto.imgGrande, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.foto.titulo,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        "Autor ID: ${widget.foto.autorId}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.photo_album,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Álbum: ${widget.foto.albumId}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.foto.descricao ?? "Sem descrição.",
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            /* Lógica do mapa */
                          },
                          icon: const Icon(Icons.map),
                          label: const Text(
                            "Ver no mapa",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            /* Lógica de email */
                          },
                          icon: const Icon(Icons.email),
                          label: const Text(
                            "Enviar email",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EnvioComentarioPage(fotoId: widget.foto.id),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 40, thickness: 1),
                  // --- COMENTÁRIOS ---
                  const Text(
                    "Comentários",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Watch((_) {
                    if (controller.isLoadingComentarios.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final comentarios = controller.comentarios.value;

                    if (comentarios.isEmpty) {
                      return const Text("Seja o primeiro a comentar!");
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comentarios.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final comentario = comentarios[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.blue[100],
                                    child: Text(
                                      comentario.titulo[0].toUpperCase(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      comentario.emailUsario ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(comentario.texto),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
