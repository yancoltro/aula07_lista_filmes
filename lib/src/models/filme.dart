class Filme {
  late int id;
  late String titulo;
  late double mediaVotos;
  late String dataLancamento;
  late String descricao;
  late String posterPath;

  Filme(
    this.id,
    this.titulo,
    this.mediaVotos,
    this.dataLancamento,
    this.descricao,
    this.posterPath,
  );

  Filme.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.titulo = json['title'];
    this.mediaVotos = json['vote_average'] * 1.0;
    this.dataLancamento = json['release_date'];
    this.descricao = json['overview'];
    this.posterPath = json['poster_path'] ?? null;
  }
}
