import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/screens/session_screen.dart';
import 'package:kumon_assessment_app/screens/session_history_screen.dart';
import 'package:kumon_assessment_app/screens/settings_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);
    final questionNotifier = ref.read(questionProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Kumon Instructor App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Session History'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SessionHistoryScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              const totalCooldownSeconds = 20; // Total cooldown duration
              final timeLeft = questionState.isCooldownActive &&
                      questionState.cooldownEnd != null
                  ? questionState.cooldownEnd!
                      .difference(DateTime.now())
                      .inSeconds
                  : 0;
              if (timeLeft <= 0 && questionState.isCooldownActive) {
                questionNotifier.checkCooldown();
              }

              final isCooldownActive = timeLeft > 0;
              final progress = isCooldownActive
                  ? (totalCooldownSeconds - timeLeft) / totalCooldownSeconds
                  : 1.0;
              final endTime = questionState.cooldownEnd != null
                  ? DateFormat('HH:mm').format(questionState.cooldownEnd!)
                  : '';

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isCooldownActive
                        ? null
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SessionScreen()),
                            ),
                    child: const Text('Start Session'),
                  ),
                  const SizedBox(height: 20),
                  if (isCooldownActive) ...[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                        Text(
                          '$timeLeft',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Cooldown ends at $endTime',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ] else ...[
                    const Text(
                      'Ready to start!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}