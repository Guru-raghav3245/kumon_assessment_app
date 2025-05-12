import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/screens/session_screen.dart';
import 'package:kumon_assessment_app/screens/session_history_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);
    final questionNotifier = ref.read(questionProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Kumon Instructor App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: Text('Session History'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SessionHistoryScreen()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1)),
            builder: (context, snapshot) {
              final totalCooldownSeconds = 20; // Total cooldown duration
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
                                builder: (_) => SessionScreen())),
                    child: Text('Start Session'),
                  ),
                  SizedBox(height: 20),
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
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                        Text(
                          '$timeLeft',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cooldown ends at $endTime',
                      style: TextStyle(fontSize: 16),
                    ),
                  ] else ...[
                    Text(
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