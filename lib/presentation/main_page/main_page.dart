import 'package:flutter/material.dart';
import 'package:photo_album/presentation/detalhes_foto/detalhes_foto_page.dart';
import 'package:photo_album/presentation/main_page/card_foto.dart';
import 'package:photo_album/presentation/detalhes_foto/foto_controller.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<FotoController>();
      if (controller.fotos.value.isEmpty && !controller.isLoading.value) {
        controller.carregarFotos();
      }
    });
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
              controller: controller.getSearchController,
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
                    controller.getSearchController.clear();
                    controller.limparFiltro();
                    controller.filtrar('');
                  },
                ),
              ),
              onChanged: (valor) {
                controller.filtrar(valor);
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Watch((_) {
              final isLoading = controller.isLoading.value;
              final error = controller.error.value;
              final fotos = controller.fotos.value;
              final semFotos = controller.semFotos;

              if (isLoading && semFotos.value) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (error != null && semFotos.value) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Ops! Ocorreu um erro.",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () => controller.carregarFotos(),
                          icon: const Icon(Icons.refresh),
                          label: const Text("Tentar Novamente"),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (semFotos.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Nenhuma foto encontrada.",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                );
              }
              final isLoadingMore = controller.isLoadingMore.value;
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.recarregarFotos();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: fotos.length + (isLoadingMore ? 1 : 0),
                  controller: controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == fotos.length && isLoadingMore) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    final foto = fotos[index];
                    return CardFoto(
                      foto: foto,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalheFotoPage(foto),
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
