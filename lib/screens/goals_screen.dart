import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/goal.dart';
import '../repositories/goal_repository.dart';
import '../repositories/trip_repository.dart';
import '../services/auth_service.dart';
import '../services/stats_service.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late Future<List<GoalProgress>> _goalsFuture;

  @override
  void initState() {
    super.initState();
    _refreshGoals();
  }

  void _refreshGoals() {
    setState(() {
      _goalsFuture = _loadGoals();
    });
  }

  Future<List<GoalProgress>> _loadGoals() async {
    final auth = context.read<AuthService>();
    final goalRepo = context.read<GoalRepository>();
    final tripRepo = context.read<TripRepository>();
    final userId = auth.currentUser?.id ?? 'guest';

    final goals = await goalRepo.getAllGoals(userId);
    final trips = await tripRepo.getTrips(userId);
    return goals
        .map((goal) => StatsService.computeGoalProgress(goal, trips))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.goals_title)),
      body: FutureBuilder<List<GoalProgress>>(
        future: _goalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(l10n.generic_error('${snapshot.error}')));
          }

          final goals = snapshot.data ?? const [];
          if (goals.isEmpty) {
            return _EmptyGoalsState(onCreate: _showCreateGoalDialog, l10n: l10n);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final progress = goals[index];
              return _GoalCard(
                progress: progress,
                l10n: l10n,
                onDelete: () => _deleteGoal(progress.goal.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateGoalDialog,
        icon: const Icon(Icons.flag),
        label: Text(l10n.goals_new_goal_button),
      ),
    );
  }

  Future<void> _showCreateGoalDialog() async {
    final auth = context.read<AuthService>();
    final goalRepo = context.read<GoalRepository>();
    final userId = auth.currentUser?.id ?? 'guest';
    final l10n = AppLocalizations.of(context)!;

    final titleController = TextEditingController();
    final yearController = TextEditingController(text: DateTime.now().year.toString());
    final targetController = TextEditingController(text: '5');

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.goals_dialog_title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: l10n.goals_field_title_label),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: yearController,
                decoration: InputDecoration(labelText: l10n.goals_field_year_label),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: targetController,
                decoration: InputDecoration(labelText: l10n.goals_field_target_label),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.btn_cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final year = int.tryParse(yearController.text) ?? 0;
                final target = int.tryParse(targetController.text) ?? 0;
                if (title.isEmpty || year <= 0 || target <= 0) {
                  return;
                }
                final now = DateTime.now();
                final goal = GoalModel(
                  id: now.microsecondsSinceEpoch.toString(),
                  userId: userId,
                  title: title,
                  type: GoalModel.typeCountriesPerYear,
                  targetValue: target,
                  year: year,
                  createdAt: now,
                  updatedAt: now,
                );

                await goalRepo.addGoal(goal);
                if (!mounted) return;
                if (!dialogContext.mounted) return;
                Navigator.of(dialogContext).pop(true);
              },
              child: Text(l10n.btn_save),
            ),
          ],
        );
      },
    );

    if (created == true && mounted) {
      _refreshGoals();
    }
  }

  Future<void> _deleteGoal(String goalId) async {
    final goalRepo = context.read<GoalRepository>();
    await goalRepo.deleteGoal(goalId);
    if (!mounted) return;
    _refreshGoals();
  }
}

class _GoalCard extends StatelessWidget {
  final GoalProgress progress;
  final AppLocalizations l10n;
  final VoidCallback onDelete;

  const _GoalCard({required this.progress, required this.l10n, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final goal = progress.goal;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(l10n.goals_card_year_label(goal.year), style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l10n.goals_delete_tooltip,
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.goals_card_progress_label(progress.currentValue, goal.targetValue),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress.progress,
                minHeight: 10,
                backgroundColor: colorScheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${(progress.progress * 100).toStringAsFixed(0)}%',
                style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyGoalsState extends StatelessWidget {
  final VoidCallback onCreate;
  final AppLocalizations l10n;

  const _EmptyGoalsState({required this.onCreate, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flag_circle_outlined, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            l10n.goals_empty_title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.goals_empty_description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onCreate,
            icon: const Icon(Icons.add),
            label: Text(l10n.goals_empty_cta),
          ),
        ],
      ),
    );
  }
}
