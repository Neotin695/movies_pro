import 'dart:convert';

import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      results: List<Results>.from(
        (map['results']).map<Results>(
          (x) => Results.fromMap(x),
        ),
      ),
    );
  }

  static String backdropPathImage(String path){
    return 'https://image.tmdb.org/t/p/w500$path';
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
