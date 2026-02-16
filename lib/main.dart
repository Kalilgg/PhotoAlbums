import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/datasource/comentario_data_source_impl.dart';
import 'package:photo_album/data/datasource/foto_data_source_impl.dart';
import 'package:photo_album/domain/repositories_impl/comentario_repository_impl.dart';
import 'package:photo_album/domain/repositories_impl/foto_repository_impl.dart';
import 'package:photo_album/presentation/main_page/foto_controller.dart';
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
        Provider<FotoController>(
          create: (_) => FotoController(
            FotoRepositoryImpl(FotoDataSourceImpl(Dio())),
            ComentarioRepositoryImpl(ComentarioDataSourceImpl(Dio())),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Photo Album',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
        ),
        home: const MainPage(),
      ),
    );
  }
}