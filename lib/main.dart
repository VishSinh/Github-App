import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:github_app/services/initializers.dart';
import 'package:github_app/views/home.dart';

void main() {
  runApp(const GithubApp());
  initializeDependencies();
}

class GithubApp extends StatelessWidget {
  const GithubApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(useMaterial3: true),
      );
}
