import 'package:flutter/material.dart';
import 'package:store/core/di/injection_container.dart' as di;
import 'package:store/features/splashscreen/presentation/pages/splashscreen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the dependency injection container
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreenPage(),
    );
  }
}
