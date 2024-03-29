import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepoCommits extends StatelessWidget {
  const RepoCommits({Key? key}) : super(key: key);

  Row keyValuePair(String key, String value) {
    void processDate() {
      final date = DateTime.parse(value);
      value = '${date.day}/${date.month}/${date.year}';
    }

    if (key == 'Date') processDate();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: (Get.width / 4),
          child: Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
        ),
        SizedBox(
          width: Get.width / 2,
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, overflow: TextOverflow.clip),
            softWrap: true,
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final commits = Get.arguments;
    print(commits);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Commits'),
      ),
      body: LiveList(
        delay: const Duration(milliseconds: 10),
        showItemInterval: const Duration(milliseconds: 100),
        visibleFraction: 0.05,
        itemCount: commits.length,
        itemBuilder: (context, index, animation) {
          final commit = commits[index]['commit'];
          final authorName = commit['author']['name'] ?? '';
          final message = commit['message'] ?? '';
          final date = commit['author']['date'] ?? '';

          return FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(-0.1, 0), end: Offset.zero).animate(animation),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    keyValuePair('Author', authorName),
                    const Divider(color: Colors.white),
                    keyValuePair('Date', date),
                    const Divider(color: Colors.white),
                    keyValuePair('Message', message),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // ListView.builder(
      //   itemCount: commits.length,
      //   itemBuilder: (context, index) {
      //     final commit = commits[index]['commit'];
      //     print('Commit: $commit');
      //     final authorName = commit['author']['name'] ?? '';
      //     final message = commit['message'] ?? '';
      //     final date = commit['author']['date'] ?? '';

      //     return Container(
      //       padding: const EdgeInsets.all(16.0),
      //       margin: const EdgeInsets.all(8.0),
      //       decoration: BoxDecoration(
      //         color: Colors.grey[800],
      //         borderRadius: BorderRadius.circular(12.0),
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           keyValuePair('Author', authorName),
      //           const Divider(color: Colors.white),
      //           keyValuePair('Date', date),
      //           const Divider(color: Colors.white),
      //           keyValuePair('Message', message),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
