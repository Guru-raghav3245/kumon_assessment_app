import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/screens/home_screen.dart';
import 'package:kumon_assessment_app/screens/session_review_screen.dart';
import 'package:kumon_assessment_app/theme_provider.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    final lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
    );

    final darkTheme = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kumon Instructor App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeState.themeMode == ThemeModeOption.light
          ? ThemeMode.light
          : ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/review': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          final session = args['session'] as Session;
          final isNewSession = args['isNewSession'] as bool? ?? false;
          return SessionReviewScreen(
            session: session,
            isNewSession: isNewSession,
          );
        },
      },
    );
  }
}
