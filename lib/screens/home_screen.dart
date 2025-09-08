import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/screens/session_screen.dart';
import 'package:kumon_assessment_app/screens/session_history_screen.dart';
import 'package:kumon_assessment_app/screens/settings_screen.dart';
import 'package:kumon_assessment_app/screens/analytics_screen.dart';
import 'package:kumon_assessment_app/screens/professional_analytics_screen.dart';
import 'dart:async';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? _cooldownTimer;
  int _millisecondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCooldownTimer();
    });
  }

  void _startCooldownTimer() {
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final questionState = ref.read(questionProvider);
      if (questionState.isCooldownActive && questionState.cooldownEnd != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        _millisecondsRemaining = questionState.cooldownEnd! - now;

        if (_millisecondsRemaining <= 0) {
          ref.read(questionProvider.notifier).clearCooldown();
          _millisecondsRemaining = 0;
          timer.cancel();
        }
        setState(() {});
      } else {
        _millisecondsRemaining = 0;
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(int milliseconds) {
    if (milliseconds <= 0) return '00:00:00';

    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  Widget _buildCooldownTimer(int millisecondsRemaining) {
    const totalCooldown = 20 * 60 * 60 * 1000; // 20 hours in milliseconds
    final progress = 1.0 - (millisecondsRemaining / totalCooldown);

    return Column(
      children: [
        const SizedBox(height: 24),
        // Status text
        Text(
          'Next session available in:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 20),
        // Timer circle with text
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue.shade300,
              width: 8,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Progress indicator
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              // Timer text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatDuration(millisecondsRemaining),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'HH:MM:SS',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Skip button
        ElevatedButton.icon(
          onPressed: () {
            // Skip the cooldown for testing
            ref.read(questionProvider.notifier).clearCooldown();
            _millisecondsRemaining = 0;
            setState(() {});
          },
          icon: const Icon(Icons.skip_next, size: 18),
          label: const Text('Skip Cooldown'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionProvider);
    final isCooldownActive =
        questionState.isCooldownActive && _millisecondsRemaining > 0;

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
                  MaterialPageRoute(
                      builder: (_) => const SessionHistoryScreen()),
                );
              },
            ),
            // Add to the Drawer's ListView children:
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Progress Analytics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Professional Analytics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ProfessionalAnalyticsScreen()),
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
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Start Session Button
                  ElevatedButton.icon(
                    onPressed: isCooldownActive
                        ? null
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SessionScreen()),
                            ),
                    icon: const Icon(Icons.play_arrow, size: 24),
                    label: const Text(
                      'Start Session',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),

                  // Cooldown Timer or Ready Message
                  if (isCooldownActive)
                    _buildCooldownTimer(_millisecondsRemaining)
                  else
                    Column(
                      children: [
                        const SizedBox(height: 24),
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade600,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Ready to start!',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
