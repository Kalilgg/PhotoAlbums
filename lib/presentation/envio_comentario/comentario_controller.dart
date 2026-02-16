import 'package:flutter/material.dart';
import 'package:photo_album/data/repositories/comentario_repository.dart';
import 'package:photo_album/domain/entities/comentario.dart';
import 'package:photo_album/domain/usecases/adicionar_comentario.dart';
import 'package:photo_album/domain/usecases/listar_comentarios_foto.dart';
import 'package:photo_album/presentation/detalhes_foto/foto_controller.dart';
import 'package:signals/signals_flutter.dart';

class ComentarioController {
  FotoController fotoController;
  ComentarioController(this.comentarioRepository, this.fotoController);

  final ComentarioRepository comentarioRepository;

  final _tituloController = TextEditingController();
  final _bodyController = TextEditingController();

  Signal<bool> isLoadingComentarios = signal(false);

  TextEditingController get titulo => _tituloController;
  TextEditingController get body => _bodyController;

  void limparCampos() {
    _tituloController.clear();
    _bodyController.clear();
  }

  bool validarCampos() {
    return (titulo.text.trim().isNotEmpty && body.text.trim().isNotEmpty);
  }

  Future<void> enviarComentario(int fotoId) async {
    final novoComentario = Comentario(
      postId: fotoId,
      titulo: titulo.text,
      emailUsario: "usuario@example.com",
      texto: body.text,
    );
    fotoController.comentarios.value = [
      ...fotoController.comentarios.value,
      novoComentario,//Requisições falhando
    ];
    final comentarioEnviado = await AdicionarComentario(
      comentarioRepository,
    ).call(novoComentario);
    limparCampos();
  }

  Future<void> carregarComentarios(int fotoId) async {
    isLoadingComentarios.value = true;
    fotoController.comentarios.value.clear();
    List<Comentario> resultado = await ListarComentariosFoto(
      comentarioRepository,
    ).call(fotoId);
    fotoController.comentarios.value.addAll(resultado);
    isLoadingComentarios.value = false;
  }
}
