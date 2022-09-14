import 'package:aula07_lista_filmes/src/screens/favoritos_filmes.dart';
import 'package:aula07_lista_filmes/src/screens/lista_filmes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// https://www.themoviedb.org/
Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(AppFilmes());
}
// void main() => runApp(AppFilmes());

class AppFilmes extends StatelessWidget {
  const AppFilmes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Filmes"),
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.all(10),
                  child: Text(
                    'Bem-vindo ao catálogo de filmes',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(10),
                  child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/4221/4221419.png',
                      height: 350),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ListaFilmes()));
                    },
                    child: Text('Lançamentos'),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => FavoritosFilmes()));
                    },
                    child: Text('Meus Favoritos'),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
