import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/datasource/album_data_source.dart';
import 'package:photo_album/data/datasource/album_data_source_impl.dart';
import 'package:photo_album/data/datasource/autor_data_source.dart';
import 'package:photo_album/data/datasource/autor_data_source_impl.dart';
import 'package:photo_album/data/datasource/comentario_data_source.dart';
import 'package:photo_album/data/datasource/comentario_data_source_impl.dart';
import 'package:photo_album/data/datasource/foto_data_source.dart';
import 'package:photo_album/data/datasource/foto_data_source_impl.dart';
import 'package:photo_album/data/repositories/album_repository.dart';
import 'package:photo_album/data/repositories/autor_repository.dart';
import 'package:photo_album/data/repositories/comentario_repository.dart';
import 'package:photo_album/data/repositories/foto_repository.dart';
import 'package:photo_album/domain/repositories_impl/album_repository_impl.dart';
import 'package:photo_album/domain/repositories_impl/autor_repository_impl.dart';
import 'package:photo_album/domain/repositories_impl/comentario_repository_impl.dart';
import 'package:photo_album/domain/repositories_impl/foto_repository_impl.dart';
import 'package:photo_album/presentation/detalhes_foto/foto_controller.dart';
import 'package:photo_album/presentation/envio_comentario/comentario_controller.dart';
import 'package:photo_album/presentation/main_page/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 1. Cliente HTTP
        Provider<Dio>(create: (_) => Dio()),

        // 2. DataSources
        ProxyProvider<Dio, FotoDataSource>(
          update: (_, dio, __) => FotoDataSourceImpl(dio),
        ),
        ProxyProvider<Dio, AlbumDataSource>(
          update: (_, dio, __) => AlbumDataSourceImpl(dio),
        ),
        ProxyProvider<Dio, AutorDataSource>(
          update: (_, dio, __) => AutorDataSourceImpl(dio),
        ),
        ProxyProvider<Dio, ComentarioDataSource>(
          update: (_, dio, __) => ComentarioDataSourceImpl(dio),
        ),

        // 3. REPOSITORIES
        ProxyProvider<FotoDataSource, FotoRepository>(
          update: (_, dataSource, __) => FotoRepositoryImpl(dataSource),
        ),
        ProxyProvider<AlbumDataSource, AlbumRepository>(
          update: (_, dataSource, __) => AlbumRepositoryImpl(dataSource),
        ),
        ProxyProvider<AutorDataSource, AutorRepository>(
          update: (_, dataSource, __) => AutorRepositoryImpl(dataSource),
        ),
        ProxyProvider<ComentarioDataSource, ComentarioRepository>(
          update: (_, dataSource, __) => ComentarioRepositoryImpl(dataSource),
        ),

        // 4. Controllers
        ProxyProvider3<
          FotoRepository, 
          AutorRepository, 
          AlbumRepository, 
          FotoController
        >(
          update: (_, fotoRepo, autorRepo, albumRepo, __) =>
              FotoController(fotoRepo, autorRepo, albumRepo),
        ),
        
        ProxyProvider2<
          ComentarioRepository, 
          FotoController, 
          ComentarioController
        >(
          update: (_, comentarioRepo, fotoController, __) =>
              ComentarioController(comentarioRepo, fotoController),
        ),
      ],
      child: MaterialApp(
        title: 'Photo Album',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        ),
        home: const MainPage(),
      ),
    );
  }
}