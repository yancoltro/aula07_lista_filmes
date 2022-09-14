// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:aula07_lista_filmes/src/helpers/http_helper.dart';
import 'package:aula07_lista_filmes/src/screens/detalhes_filmes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../models/filme.dart';

class ListaFilmes extends StatefulWidget {
  // const ListaFilmes({Key? key}) : super(key: key);

  @override
  State<ListaFilmes> createState() => _ListaFilmesState();
}

class _ListaFilmesState extends State<ListaFilmes> {
  // late String result;
  late HttpHelper helper;

  int filmesCount = 0;
  List<Filme> filmes = [];

  final String defaultPathImage = 'https://image.tmdb.org/t/p/w92/';
  final String defaultPoster =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Icon iconeSearchBar = Icon(Icons.search);
  Widget searchBar = Text('Listagem de filmes');

  @override
  void initState() {
    helper = new HttpHelper();
    initialize();
    super.initState();
    // result = '';
  }

  Future initialize() async {
    filmes = await helper.getLancamentos();
    setState(() {
      filmesCount = filmes.length;
      filmes = filmes;
    });
  }

  Future search(String titulo) async {
    filmes = await helper.buscaFilme(titulo);
    setState(() {
      filmesCount = filmes.length;
      filmes = filmes;
    });
  }

  @override
  Widget build(BuildContext context) {
    // helper.getLancamentos().then((value) {
    //   setState(() {
    //     result = value;
    //   });
    // },);

    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
              icon: iconeSearchBar,
              onPressed: () {
                setState(() {
                  if (this.iconeSearchBar.icon == Icons.search) {
                    this.iconeSearchBar = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      onSubmitted: (String titulo) {
                        search(titulo);
                      },
                    );
                  } else {
                    this.setState(() {
                      this.iconeSearchBar = Icon(Icons.search);
                      this.searchBar = Text('Listagem de filmes');
                    });
                  }
                });
              }),
        ],
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

                return Card(
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
                );
              }))),
    );
  }
}
