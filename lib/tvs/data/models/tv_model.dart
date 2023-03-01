import 'dart:convert';

import 'package:movies_pro/tvs/domain/entities/tv.dart';

class TVsModel extends TVs {
  const TVsModel({
    required super.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory TVsModel.fromMap(Map<String, dynamic> map) {
    return TVsModel(
      results: List<Results>.from(
        (map['results']).map<Results>(
          (x) => Results.fromMap(x),
        ),
      ),
    );
  }

  static String? backdropPathImage(String path) {
    return 'https://image.tmdb.org/t/p/w500$path';
  }

  String toJson() => json.encode(toMap());

  factory TVsModel.fromJson(String source) =>
      TVsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
