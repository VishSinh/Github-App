import 'package:get/get.dart';
import 'package:github_app/helpers/consts.dart';
import 'package:github_app/services/user_services.dart';

class ReposController extends GetxController {
  final commits = [].obs;
  final recentCommit = {}.obs;

  Future<void> fetchRepoCommits(String repo, String username) async {
    Map<String, dynamic> res = await UserServices.getRepoCommits(username, repo);

    if (res['success'] == false) throw Exception(res['message']);

    // log.i(res);

    log.i(res['data'][0]['commit']);

    commits.value = res['data'];
    recentCommit.value = res['data'][0]['commit'];
  }
}
