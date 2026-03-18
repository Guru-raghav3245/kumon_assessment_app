import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kumon_assessment_app/screens/professional_anaytics_screen.dart';
import 'package:kumon_assessment_app/state_management.dart';
import 'package:kumon_assessment_app/screens/session_screen.dart';
import 'package:kumon_assessment_app/screens/session_history_screen.dart';
import 'package:kumon_assessment_app/screens/settings_screen.dart';
import 'package:kumon_assessment_app/question_logic/models.dart';
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
    // Immediately calculate the correct cooldown state when we land on Home
    _updateCooldownState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCooldownTimer();
    });
  }

  // NEW: Syncs the provider cooldown with our local timer variable
  void _updateCooldownState() {
    final questionState = ref.read(questionProvider);
    if (questionState.isCooldownActive && questionState.cooldownEnd != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      _millisecondsRemaining = questionState.cooldownEnd! - now;

      if (_millisecondsRemaining <= 0) {
        ref.read(questionProvider.notifier).clearCooldown();
        _millisecondsRemaining = 0;
      }
    } else {
      _millisecondsRemaining = 0;
    }
  }

  void _startCooldownTimer() {
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCooldownState(); // Keep countdown accurate
      setState(() {});
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

  void _showFilterDialog(BuildContext context, QuestionLevel? currentFilter) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Session Filter',
              style: TextStyle(fontSize: 18)),
          contentPadding: const EdgeInsets.only(top: 16),
          content: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.shuffle),
                  title: const Text('Default (Mixed Subjects)'),
                  trailing: currentFilter == null
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref.read(questionProvider.notifier).setFilter(null);
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ...QuestionLevel.values.map((level) {
                  return ListTile(
                    title: Text(formatLevelName(level.toString())),
                    trailing: currentFilter == level
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      ref.read(questionProvider.notifier).setFilter(level);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCooldownTimer(int millisecondsRemaining) {
    const totalCooldown = 20 * 60 * 60 * 1000;
    final progress = 1.0 - (millisecondsRemaining / totalCooldown);

    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          'Next session available in:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 20),
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
        ElevatedButton.icon(
          onPressed: () {
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

    // Cooldown is active ONLY when provider flag is true AND we have positive remaining time
    final bool isCooldownActive =
        questionState.isCooldownActive && _millisecondsRemaining > 0;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                  // Filter UI Box
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.blue.withOpacity(0.15)
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.blue.withOpacity(0.3)
                            : Colors.blue.shade100,
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.tune,
                          color: isDarkMode
                              ? Colors.blue.shade300
                              : Colors.blue.shade700),
                      title: Text('Session Target',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          )),
                      subtitle: Text(
                        questionState.selectedFilterLevel == null
                            ? 'Default (1 Math, 1 Eng, 1 Comp)'
                            : formatLevelName(
                                questionState.selectedFilterLevel.toString()),
                        style: TextStyle(
                            color: isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade700),
                      ),
                      trailing: Icon(Icons.edit,
                          size: 20,
                          color: isDarkMode
                              ? Colors.blue.shade300
                              : Colors.blue.shade700),
                      onTap: isCooldownActive
                          ? null
                          : () => _showFilterDialog(
                              context, questionState.selectedFilterLevel),
                    ),
                  ),
                  const SizedBox(height: 24),

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
                          color: isDarkMode
                              ? Colors.green.shade400
                              : Colors.green.shade600,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Ready to start!',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: isDarkMode
                                        ? Colors.green.shade400
                                        : Colors.green.shade700,
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
