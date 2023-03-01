import 'package:movies_pro/core/error/error_network/repository/server_exception.dart';
import 'package:movies_pro/core/utils/app_constance.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/error_network/models/error_message_model.dart';
import '../models/now_playing_movie_model.dart';

abstract class BaseRemoteMoviesDataSource {
  Future<MovieModel> getNowPlayingMovies();
  Future<MovieModel> getPopularMovies();
  Future<MovieModel> getTopRatedMovies();
}

class MoviesRemoteDataSource implements BaseRemoteMoviesDataSource {
  final int success = 200;

  @override
  Future<MovieModel> getNowPlayingMovies() async {
    return await getResponseByQuery('now_playing');
  }

  @override
  Future<MovieModel> getPopularMovies() async {
    return await getResponseByQuery('popular');
  }

  @override
  Future<MovieModel> getTopRatedMovies() async {
    return await getResponseByQuery('top_rated');
  }

  Future<MovieModel> getResponseByQuery(String query) async {
    http.Response response = await sendRequestToApi(query);

    if (checkIfResponseIsSuccessfulByStatusCode(response.statusCode)) {
      return MovieModel.fromJson(response.body);
    } else {
      throw ServerExceptionRepository(
          errorMessage: ErrorMessageModel.fromJson(response.body));
    }
  }

  Future<http.Response> sendRequestToApi(String query) async {
    final response = await http.get(Uri.parse(
        '${AppConstance.baseUrl}/movie/$query?api_key=${AppConstance.apiKey}'));
    return response;
  }

  bool checkIfResponseIsSuccessfulByStatusCode(int statusCode) {
    return statusCode == success;
  }
}
