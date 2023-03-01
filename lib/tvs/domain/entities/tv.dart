// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TVs extends Equatable {
  final List<Results> results;

  const TVs({
    required this.results,
  });

  @override
  List<Object?> get props => [
        results,
      ];
}

class Results {
  String? backdropPath;
  String firstAirDate;
  List<int> genreIds;
  int id;
  String name;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  double voteAverage;
  int voteCount;

  Results({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genre_ids': genreIds,
      'id': id,
      'name': name,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory Results.fromMap(Map<String, dynamic> map) {
    return Results(
      backdropPath: map['backdrop_path'].toString(),
      firstAirDate: map['first_air_date'] as String,
      genreIds: List<int>.from(map['genre_ids'].map((e) => e)),
      id: map['id'] as int,
      name: map['name'] as String,
      originCountry: List<String>.from(map['origin_country'].map((e) => e)),
      originalLanguage: map['original_language'] as String,
      originalName: map['original_name'] as String,
      overview: map['overview'] as String,
      popularity: map['popularity'] as double,
      posterPath: map['poster_path'] as String,
      voteAverage: double.parse(map['vote_average'].toString()),
      voteCount: map['vote_count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Results.fromJson(String source) =>
      Results.fromMap(json.decode(source) as Map<String, dynamic>);
}
