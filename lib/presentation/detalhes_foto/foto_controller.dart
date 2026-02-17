import 'package:flutter/material.dart';
import 'package:photo_album/data/repositories/album_repository.dart';
import 'package:photo_album/data/repositories/autor_repository.dart';
import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/entities/album.dart';
import 'package:photo_album/domain/entities/autor.dart';
import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/domain/entities/foto.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_similarity/string_similarity.dart';

class FotoController {
  final FotoRepository _fotoRepository;
  final AutorRepository _autorRepository;
  final AlbumRepository _albumRepository;

  FotoController(
    this._fotoRepository,
    this._autorRepository,
    this._albumRepository,
  ) {
    configurarScrollListener();
  }

  int _comeco = 0;
  final int _quantidade = 20;
  late final scrollController = ScrollController();
  final hasMore = signal(true);
  final _todasFotos = signal<List<Foto>>([]);
  Signal termoBusca = signal('');
  Signal<bool> carregarMais = signal(false);
  Signal<bool> semFotos = signal(false);

  final searchController = TextEditingController();
  TextEditingController get getSearchController => searchController;

  void limparFiltro() {
    termoBusca = signal('');
  }

  late final fotos = computed(() {
    int? termoNumerico = int.tryParse(termoBusca.value.toString().trim());
    final termo = termoBusca.value.trim().toLowerCase();
    final lista = _todasFotos.value;

    if (lista.isEmpty) return lista;
    if (termo.isEmpty) return lista;

    if (termoNumerico != null) {
      return lista.where((foto) => foto.id == termoNumerico).take(20).toList();
    }
    if (termo.isEmpty) return lista;
    final listaOrdenada =
        lista
            .map(
              (foto) => {
                'foto': foto,
                'rating': StringSimilarity.compareTwoStrings(
                  termo,
                  foto.titulo,
                ),
              },
            )
            .toList()
          ..sort(
            (a, b) => (b['rating'] as double).compareTo(a['rating'] as double),
          );
    return listaOrdenada.map((e) => e['foto'] as Foto).take(20).toList();
  });

  final isLoading = signal(false);
  final error = signal<String?>(null);

  Signal<List<Comentario>> comentarios = signal([]);

  Signal autor = signal<Autor?>(null);
  Signal album = signal<Album?>(null);

  Future<void> carregarFotos() async {
    if(_comeco == 100) {
      hasMore.value = false;
      return;
    };
    if (!hasMore.value) return;
    if (isLoading.value) return;
    isLoading.value = true;
    error.value = null;
    await Future.delayed(Duration(milliseconds: 300));

    final resultado = await _fotoRepository.listar(_comeco, _quantidade);
    if (resultado.isEmpty) {
      error.value = "Nenhuma foto encontrada.";
      semFotos.value = true;
      hasMore.value = false;
      isLoading.value = false;
      return;
    }
    _todasFotos.value = [..._todasFotos.value, ...resultado];
    _comeco += _quantidade;
    isLoading.value = false;
  }

  void configurarScrollListener() {
    scrollController.addListener(() {
      if ((scrollController.position.maxScrollExtent * 0.50) <=
              scrollController.offset &&
          hasMore.value) {
        carregarFotos();
      }
    });
  }

  void filtrar(String query) {
    termoBusca.value = query;
  }

  Future<void> recarregarFotos() async {
    _comeco = 0;
    final resultado = await _fotoRepository.listar(_comeco, _quantidade);
    if (resultado.isEmpty) {
      error.value = "Nenhuma foto encontrada.";
    } else {
      _todasFotos.value = [];
      hasMore.value = true;
      _todasFotos.value = resultado;
      _comeco += _quantidade;
      isLoading.value = false;
    }
  }

  Future<void> buscarAutor(int autorId) async {
    autor.value = null;
    autor.value = await _autorRepository.selecionar(autorId);
  }

  Future<void> buscarAlbum(int albumId) async {
    album.value = null;
    album.value = await _albumRepository.selecionar(albumId);
  }
}
