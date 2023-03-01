import 'dart:convert';

import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final List<Results> results;

  const Movie({
    required this.results,
  });

  @override
  List<Object?> get props => [
        results,
      ];
}

class Results {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Results({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdropPath': backdropPath,
      'genreIds': genreIds,
      'id': id,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'title': title,
      'video': video,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      adult: map['adult'] as bool,
      backdropPath: map['backdrop_path'] as String,
      genreIds: List<int>.from(map['genre_ids'].map((e) => e)),
      id: map['id'] as int,
      originalLanguage: map['original_language'] as String,
      originalTitle: map['original_title'] as String,
      overview: map['overview'] as String,
      popularity: map['popularity'] as double,
      posterPath: map['poster_path'] as String,
      releaseDate: map['release_date'] as String,
      title: map['title'] as String,
      video: map['video'] as bool,
      voteAverage: double.parse(map['vote_average'].toString()),
      voteCount: map['vote_count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Results.fromJson(String source) =>
      Results.fromMap(json.decode(source) as Map<String, dynamic>);
}
