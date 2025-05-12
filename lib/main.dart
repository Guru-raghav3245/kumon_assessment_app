import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/screens/home_screen.dart';
import 'package:kumon_assessment_app/screens/session_summary_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kumon Instructor App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      // In main.dart
      routes: {
        '/': (context) => const HomeScreen(),
        '/summary': (context) {
          final results = ModalRoute.of(context)!.settings.arguments
              as List<Map<String, String>>;
          return SessionSummaryScreen(results: results);
        },
      },
    );
  }
}
