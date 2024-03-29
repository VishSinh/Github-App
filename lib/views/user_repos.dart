import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:github_app/controllers/repos.dart';
import 'package:github_app/controllers/username.dart';
import 'package:github_app/helpers/consts.dart';
import 'package:github_app/views/repo_commits.dart';

class UserRepos extends StatelessWidget {
  UserRepos({Key? key}) : super(key: key);

  final UsernameController usernameCtlr = Get.find<UsernameController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${usernameCtlr.username.value}\'s Repositories'),
        ),
        body: LiveList(
          delay: const Duration(milliseconds: 10),
          showItemInterval: const Duration(milliseconds: 100),
          visibleFraction: 0.05,
          itemCount: usernameCtlr.userRepos.length,
          itemBuilder: (context, index, animation) {
            final repo = usernameCtlr.userRepos[index];
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(-0.1, 0), end: Offset.zero).animate(animation),
                child: RepoInfoContainer(title: repo['name']),
              ),
            );
          },
        ),

        // ListView(
        //   children: [for (var repo in usernameCtlr.userRepos) RepoInfoContainer(title: repo['name'])],
        // ),
      ),
    );
  }
}

class RepoInfoContainer extends StatefulWidget {
  final String title;
  final double borderRadius;
  final List<Color> gradientColors;
  final EdgeInsetsGeometry padding;

  const RepoInfoContainer({
    Key? key,
    required this.title,
    this.borderRadius = 12.0,
    this.gradientColors = const [neutralDark, neutralDarker],
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  State<RepoInfoContainer> createState() => _RepoInfoContainerState();
}

class _RepoInfoContainerState extends State<RepoInfoContainer> {
  final UsernameController usernameCtlr = Get.find<UsernameController>();
  late ReposController repoCtlr;

  @override
  void initState() {
    super.initState();
    repoCtlr = Get.put(ReposController(), tag: widget.title);
    repoCtlr.fetchRepoCommits(widget.title, usernameCtlr.username.value);
  }

  Row keyValuePair(String key, String value) {
    void processDate() {
      final date = DateTime.parse(value);
      value = '${date.day}/${date.month}/${date.year}';
    }

    if (key.contains('Date')) processDate();

    return Row(
      children: [
        SizedBox(
          width: (Get.width / 4) + 10,
          child: Text(
            key,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            // textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: (Get.width / 2) + 30,
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Add a divider
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Get.to(const RepoCommits(), arguments: repoCtlr.commits),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4D4D4D).withOpacity(0.2),
                blurRadius: 4.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: widget.padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(height: 18.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => repoCtlr.recentCommit.isEmpty
                          ? const SpinKitPulse(color: Colors.white)
                          : Column(
                              children: [
                                keyValuePair('Author: ', repoCtlr.recentCommit['author']['name']),
                                const Divider(color: Colors.white),
                                keyValuePair('Recent commit: ', repoCtlr.recentCommit['message']),
                                const Divider(color: Colors.white),
                                keyValuePair('Date: ', repoCtlr.recentCommit['author']['date']),
                              ],
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
