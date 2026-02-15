import 'package:photo_album/core/util/string_comparator.dart';
import 'package:photo_album/data/repositories/comentario_repository.dart';
import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/domain/entities/foto.dart';
import 'package:signals/signals_flutter.dart';

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
    final listaClassificada = lista.map((foto) {
      int distancia;
      if (foto.id.toString() == termo) {
        distancia = -1;
      } else {
        distancia = StringComparator.compare(termo, foto.titulo.toLowerCase());
        if (foto.titulo.toLowerCase().contains(termo)) {
          distancia = distancia - 2;
        }
      }
      return {'foto': foto, 'distancia': distancia};
    }).toList();
    listaClassificada.sort((a, b) {
      final distA = a['distancia'] as int;
      final distB = b['distancia'] as int;
      return distA.compareTo(distB);
    });

    return listaClassificada
        .take(20)
        .map((item) => item['foto'] as Foto)
        .toList();
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
