import 'dart:async';

import 'package:flutter/material.dart';
import 'package:store/core/di/injection_container.dart' as di;
import 'package:sentry/sentry.dart';
import 'package:store/features/splashscreen/presentation/pages/splashscreen_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runZonedGuarded(
    () async {
      print(dotenv.env['SENTRY_DSN']);
      await Sentry.init((options) {
        options.dsn = dotenv.env['SENTRY_DSN'] ?? '';
      });

      /// Initialize the dependency injection container
      await di.init();

      // Init your App.
      runApp(const MyApp());
    },
    (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const SplashScreenPage(),
    );
  }
}
