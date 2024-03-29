import 'package:get/get.dart';
import 'package:github_app/helpers/consts.dart';
import 'package:github_app/services/user_services.dart';
import 'package:github_app/views/user_repos.dart';

class UsernameController extends GetxController {
  final username = ''.obs;
  final userRepos = [].obs;

  final ctaState = CTAState.enabled.obs;

  void setUsername(String value) {
    username.value = value;
  }

  Future<void> handleSubmit() async {
    if (username.value.isNotEmpty) {
      Map<String, dynamic> res = await UserServices.getUserRepos(username.value);

      if (res['success'] == false) throw Exception(res['message']);

      userRepos.value = res['data'];

      for (var repo in userRepos) {
        print('Repo Name: ${repo['name']}\nRepo Description: ${repo['description']} ');
      }
      Get.to(UserRepos());
    }
  }
}
