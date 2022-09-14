import 'package:aula07_lista_filmes/src/helpers/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../models/filme.dart';

class DetalhesFilmes extends StatelessWidget {
  final Filme filme;
  final String defaultPathImage = 'https://image.tmdb.org/t/p/w92/';
  final String defaultPoster =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  DetalhesFilmes(this.filme);

  final HttpHelper http = HttpHelper();

  @override
  Widget build(BuildContext context) {
    String poster;
    double posterHeight = MediaQuery.of(context).size.height;
    if (filme.posterPath != null) {
      poster = defaultPathImage + filme.posterPath;
    } else {
      poster = defaultPoster;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(filme.titulo),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(5),
                    height: posterHeight / 3,
                    child: Image.network(poster)),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(filme.descricao),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String status = await http.adicionarFavoritos(filme.id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(status)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
