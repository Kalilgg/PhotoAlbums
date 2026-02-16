import 'package:flutter/material.dart';
import 'package:photo_album/presentation/envio_comentario/comentario_controller.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

class EnvioComentarioPage extends StatelessWidget {
  final int fotoId;
  const EnvioComentarioPage({super.key, required this.fotoId});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ComentarioController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Comentar")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.titulo,
              decoration: const InputDecoration(
                hintText: "Título do comentário",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Body",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.body,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Descreva seu comentário",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              height: 50,
              child: Watch((_) {
                return ElevatedButton.icon(
                  onPressed: () async {
                    if (controller.validarCampos()) {
                      controller.enviarComentario(fotoId);
                      controller.limparCampos();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("ENVIAR"),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
