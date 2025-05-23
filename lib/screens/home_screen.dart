import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/screens/session_screen.dart';
import 'package:kumon_assessment_app/screens/session_history_screen.dart';
import 'package:kumon_assessment_app/screens/settings_screen.dart';
import 'dart:async';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final questionState = ref.read(questionProvider);
        if (questionState.isCooldownActive && questionState.cooldownEnd != null) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if (now >= questionState.cooldownEnd!) {
            ref.read(questionProvider.notifier).clearCooldown();
            timer.cancel();
          }
          setState(() {});
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  Widget _buildCooldownTimer(int secondsRemaining) {
    const totalCooldown = 20;
    final progress = secondsRemaining / totalCooldown;

    return Column(
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            Text(
              '$secondsRemaining',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Wait to start new session',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionProvider);
    final now = DateTime.now().millisecondsSinceEpoch;
    final secondsRemaining = questionState.isCooldownActive &&
            questionState.cooldownEnd != null
        ? ((questionState.cooldownEnd! - now) / 1000).ceil()
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumon Instructor Assessment'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Session History'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SessionHistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: questionState.isCooldownActive &&
                            secondsRemaining > 0
                        ? null
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SessionScreen()),
                            ),
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    label: const Text('Start Session'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  if (questionState.isCooldownActive && secondsRemaining > 0)
                    _buildCooldownTimer(secondsRemaining)
                  else
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Ready to start!',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}