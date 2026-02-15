import 'package:flutter/material.dart';

class EnvioComentarioPage extends StatefulWidget {
  final int fotoId;

  const EnvioComentarioPage({super.key, required this.fotoId});

  @override
  State<EnvioComentarioPage> createState() => _EnvioComentarioPageState();
}

class _EnvioComentarioPageState extends State<EnvioComentarioPage> {
  final _tituloController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comentar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                hintText: "Título do comentário",
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text("Body", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Descreva seu comentário",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.send),
                label: const Text("ENVIAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}