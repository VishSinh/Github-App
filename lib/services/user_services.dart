import 'dart:convert';

import 'package:github_app/services/api_helper.dart';
import 'package:github_app/services/request_maker.dart';
import 'package:http/http.dart';

class UserServices {
  static Future<Map<String, dynamic>> getUserRepos(String username) async {
    final url = APIConfig.getUserReposUrl(username);

    Map<String, dynamic> responseBody = {'success': false, 'message': 'An error occurred'};

    try {
      Response response = await RequestMaker.getRequest(url: url);

      dynamic decodedBody = json.decode(response.body);

      if (decodedBody is List && decodedBody.isEmpty) {
        responseBody['message'] = 'User not found';
        return responseBody;
      }

      responseBody['data'] = decodedBody;
      responseBody['success'] = true;
    } catch (e) {
      responseBody['message'] = e.toString();
    }

    return responseBody;
  }

  static Future<Map<String, dynamic>> getRepoCommits(String username, String repo) async {
    final url = APIConfig.getRepoCommitsUrl(username, repo);

    Map<String, dynamic> responseBody = {'success': false, 'message': 'An error occurred'};

    try {
      Response response = await RequestMaker.getRequest(url: url);

      dynamic decodedBody = json.decode(response.body);

      responseBody['data'] = decodedBody;
      responseBody['success'] = true;
    } catch (e) {
      responseBody['message'] = e.toString();
    }

    return responseBody;
  }
}
