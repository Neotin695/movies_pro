import 'package:movies_pro/core/error/error_network/repository/server_exception.dart';
import 'package:movies_pro/core/utils/app_constance.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/error_network/models/error_message_model.dart';
import '../models/tv_model.dart';

abstract class BaseRemoteTVsDataSource {
  Future<TVsModel> getNowPlayingTVs();
  Future<TVsModel> getPopularTVs();
  Future<TVsModel> getTopRatedTVs();
}

class TVsRemoteDataSource implements BaseRemoteTVsDataSource {
  final int success = 200;

  @override
  Future<TVsModel> getNowPlayingTVs() async {
    return await getResponseByQuery('on_the_air');
  }

  @override
  Future<TVsModel> getPopularTVs() async {
    return await getResponseByQuery('popular');
  }

  @override
  Future<TVsModel> getTopRatedTVs() async {
    return await getResponseByQuery('top_rated');
  }

  Future<TVsModel> getResponseByQuery(String query) async {
    http.Response response = await sendRequestToApi(query);

    if (checkIfResponseIsSuccessfulByStatusCode(response.statusCode)) {
      return TVsModel.fromJson(response.body);
    } else {
      throw ServerExceptionRepository(
          errorMessage: ErrorMessageModel.fromJson(response.body));
    }
  }

  Future<http.Response> sendRequestToApi(String query) async {
    final response = await http.get(Uri.parse(
        '${AppConstance.baseUrl}/tv/$query?api_key=${AppConstance.apiKey}'));
    return response;
  }

  bool checkIfResponseIsSuccessfulByStatusCode(int statusCode) {
    return statusCode == success;
  }
}
