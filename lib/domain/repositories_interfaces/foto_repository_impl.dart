import 'dart:math';

import 'package:photo_album/core/network/dio_client.dart';
import 'package:photo_album/data/convert/foto_converter.dart';
import 'package:photo_album/data/model_in/autor_model_in.dart';
import 'package:photo_album/data/model_in/foto_model_in.dart';
import 'package:photo_album/data/model_in/post_model_in.dart';
import 'package:photo_album/data/models/comentario.dart';
import 'package:photo_album/data/models/foto.dart';
import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/exceptions/repository_exception.dart';

class FotoRepositoryImpl implements FotoRepository {
  final DioClient _client;
  FotoRepositoryImpl(this._client);

  @override
  Future<Comentario> adicionarComentario(int fotoId, Comentario comentario) {
    // TODO: implement adicionarComentario
    throw UnimplementedError();
  }

  @override
  Future<List<Foto>> listar() async {
    try {
      final responses = await Future.wait([
        _client.api.get('/photos'),
        _client.api.get('/posts'),
        _client.api.get('/users'),
      ]);

      final fotosList = (responses[0].data as List)
          .map((e) => FotoModelIn.fromJson(e))
          .toList();
      final postsList = (responses[1].data as List)
          .map((e) => PostModelIn.fromJson(e))
          .toList();
      final autorList = (responses[2].data as List)
          .map((e) => AutorModelIn.fromJson(e))
          .toList();

      List<Foto> fotos = [];

      for (var foto in fotosList) {
        final post = postsList[foto.id];
        final album = fotosList[foto.albumId];
        if (post != null && album != null) {
          final autor = autorList[post.userId];
          fotos.add(foto.toDomain(post: post, autor: autor));
        }
      }
      return fotos;
    } catch (e) {
      throw RepositoryException(e.toString());
    }
  }

  @override
  Future<List<Comentario>> listarComentarios(int fotoId) {
    // TODO: implement listarComentarios
    throw UnimplementedError();
  }

  @override
  Future<List<Foto>> listarFotosPorAlbum(int albumId) {
    // TODO: implement listarFotosPorAlbum
    throw UnimplementedError();
  }

  @override
  Future<Foto> selecionar(int id) {
    // TODO: implement selecionar
    throw UnimplementedError();
  }
}
