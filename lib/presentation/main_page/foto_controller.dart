import 'package:photo_album/data/repositories/comentario_repository.dart';
import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/domain/entities/foto.dart';
import 'package:signals/signals_flutter.dart';
import 'package:string_similarity/string_similarity.dart';

class FotoController {
  final FotoRepository _fotoRepository;
  final ComentarioRepository _comentarioRepository;

  FotoController(this._fotoRepository, this._comentarioRepository);

  final _todasFotos = signal<List<Foto>>([]);
  Signal<String> termoBusca = signal('');
  void limparFiltro() {
    termoBusca = signal('');
  }

  late final fotos = computed(() {
    final termo = termoBusca.value.trim().toLowerCase();
    final lista = _todasFotos.value;

    if (termo.isEmpty) return lista;
    final listaOrdenada = lista
    .map((foto) => {
          'foto': foto,
          'rating': StringSimilarity.compareTwoStrings(termo, foto.titulo)
        })
    .toList()
  ..sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));

return listaOrdenada.map((e) => e['foto'] as Foto).take(20).toList();
  });

  final isLoading = signal(false);
  final error = signal<String?>(null);

  final comentarios = signal<List<Comentario>>([]);
  final isLoadingComentarios = signal(false);

  Future<void> carregarFotos() async {
    isLoading.value = true;
    error.value = null;

    final resultado = await _fotoRepository.listar();
    _todasFotos.value = resultado;
    if (resultado.isEmpty) {
      error.value = "Nenhuma foto encontrada.";
    }
    isLoading.value = false;

  }

  void filtrar(String query) {
    termoBusca.value = query;
  }

  Future<void> carregarComentarios(int fotoId) async {
    isLoadingComentarios.value = true;
    comentarios.value = [];
    final resultado = await _comentarioRepository.listar(fotoId);
    comentarios.value = resultado;
    isLoadingComentarios.value = false;
  }

  Future<void> enviarComentario(int fotoId, Comentario comentario) async {
    final novoComentario = Comentario(
      postId: fotoId,
      titulo: comentario.titulo,
      emailUsario: comentario.emailUsario,
      texto: comentario.texto,
    );
    final comentarioEnviado = await _comentarioRepository.adicionar(novoComentario);
    comentarios.value.add(comentarioEnviado);
  }

}
