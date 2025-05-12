import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<ThemeModeOption>(
              title: const Text('Light Theme'),
              value: ThemeModeOption.light,
              groupValue: themeState.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeNotifier.setTheme(value);
                }
              },
            ),
            RadioListTile<ThemeModeOption>(
              title: const Text('Dark Theme'),
              value: ThemeModeOption.dark,
              groupValue: themeState.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeNotifier.setTheme(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}