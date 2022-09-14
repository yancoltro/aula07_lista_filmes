// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:aula07_lista_filmes/src/helpers/http_helper.dart';
import 'package:aula07_lista_filmes/src/screens/detalhes_filmes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../models/filme.dart';

class FavoritosFilmes extends StatefulWidget {
  // const FavoritosFilmes({Key? key}) : super(key: key);

  @override
  State<FavoritosFilmes> createState() => _FavoritosFilmesState();
}

class _FavoritosFilmesState extends State<FavoritosFilmes> {
  // late String result;
  late HttpHelper helper;

  int filmesCount = 0;
  List<Filme> filmes = [];

  final String defaultPathImage = 'https://image.tmdb.org/t/p/w92/';
  final String defaultPoster =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  @override
  void initState() {
    helper = new HttpHelper();
    initialize();
    super.initState();
    // result = '';
  }

  Future initialize() async {
    filmes = await helper.getFavoritos();
    setState(() {
      filmesCount = filmes.length;
      filmes = filmes;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: (this.filmesCount == null) ? 0 : this.filmesCount,
              itemBuilder: ((BuildContext context, int index) {
                if (filmes[index].posterPath != null) {
                  image =
                      NetworkImage(defaultPathImage + filmes[index].posterPath);
                } else {
                  image = NetworkImage(defaultPoster);
                }

                return Dismissible(
                  key: Key(filmes[index].id.toString()),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text(
                                'Deseja realmente remover dos favoritos?'),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text('Sim'),
                                  onPressed: () async {
                                    String status = await helper
                                        .removerFavoritos(filmes[index].id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(status)));
                                    Navigator.of(context).pop(true);
                                  }),
                              TextButton(
                                child: const Text('Não'),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                              ),
                            ],
                          );
                        });
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetalhesFilmes(filmes[index])));
                      },
                      title: Text(filmes[index].titulo),
                      subtitle: Text('Lançamento: ' +
                          filmes[index].dataLancamento +
                          ' - Votos: ' +
                          filmes[index].mediaVotos.toString()),
                      leading: CircleAvatar(
                        backgroundImage: image,
                      ),
                    ),
                  ),
                );
              }))),
    );
  }
}
