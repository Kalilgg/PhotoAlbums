import 'package:flutter/material.dart';
import 'package:photo_album/presentation/detalhes_foto/detalhes_foto_page.dart';
import 'package:photo_album/presentation/main_page/card_foto.dart';
import 'package:photo_album/presentation/main_page/foto_controller.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FotoController>().carregarFotos();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FotoController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Photo Albums"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar foto, álbum ou autor...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    controller.limparFiltro();
                    controller.filtrar(''); 
                    controller.carregarFotos();
                  },
                ),
              ),
              onChanged: (valor) {
                controller.filtrar(_searchController.text);
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Watch((_) {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (controller.error.value != null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
                        const SizedBox(height: 16),
                        Text(
                          "Ops! Ocorreu um erro.",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.error.value!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => controller.carregarFotos(),
                          icon: const Icon(Icons.refresh),
                          label: const Text("Tentar Novamente"),
                        )
                      ],
                    ),
                  ),
                );
              }

              final fotos = controller.fotos.value;

              if (fotos.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported_outlined, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        "Nenhuma foto encontrada.",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.carregarFotos();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: fotos.length,
                  itemBuilder: (context, index) {
                    final foto = fotos[index];

                    return CardFoto(
                      foto: foto,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalheFotoPage(foto: foto),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}