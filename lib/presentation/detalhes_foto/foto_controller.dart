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
  final isLoadingMore = signal(false);
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
              (a, b) =>
                  (b['rating'] as double).compareTo(a['rating'] as double),
            );
      return listaOrdenada.map((e) => e['foto'] as Foto).take(20).toList();
  });

  final isLoading = signal(false);
  final error = signal<String?>(null);

  Signal<List<Comentario>> comentarios = signal([]);

  final autor = signal<Autor?>(null);
  final album = signal<Album?>(null);

  Future<void> carregarConteudo(int fotoId) async {
    await buscarAutor(fotoId);
    await buscarAlbum(fotoId);
  }

  Future<void> carregarFotos() async {
    isLoading.value = true;
    error.value = null;

    final resultado = await _fotoRepository.listar(_comeco, _quantidade);
    _todasFotos.value = resultado;
    if (resultado.isEmpty) {
      error.value = "Nenhuma foto encontrada.";
      semFotos.value = true;
    }
    _comeco += _quantidade;
    isLoading.value = false;
  }

  void configurarScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        carregarMais.value = true;
      } else {
        carregarMais.value = false;
      }
    });

    effect(() {
      if (carregarMais.value) {
        carregarMaisFotos();
      }
    });
  }

  Future<void> carregarMaisFotos() async {
    if (!hasMore.value) return;
    isLoadingMore.value = true;
    final novosItens = await _fotoRepository.listar(_comeco, _quantidade);

    if (novosItens.isEmpty) {
      hasMore.value = false;
    } else {
      fotos.internalValue.addAll(novosItens);
      _comeco += _quantidade;
    }
  }

  void filtrar(String query) {
    termoBusca.value = query;
  }

  Future<void> recarregarFotos() async {
    final resultado = await _fotoRepository.listar(0, _quantidade);
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
