import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_template/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:supabase_template/src/features/reminders/presentation/controllers/reminders_controller.dart';
import 'package:supabase_template/src/features/reminders/presentation/widgets/reminder_tile.dart';

/// Example screen that fetches data from `reminders` table in Supabase.
class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersState = ref.watch(remindersProvider);
    final authActionState = ref.watch(authControllerProvider);
    final isSigningOut = authActionState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        actions: [
          IconButton(
            onPressed: isSigningOut
                ? null
                : () async {
                    await ref.read(authControllerProvider.notifier).signOut();
                  },
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(remindersProvider.future),
        child: remindersState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) {
            final message = mapReminderError(error);
            return ListView(
              children: [
                const SizedBox(height: 96),
                Center(child: Text(message)),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    onPressed: () => ref.invalidate(remindersProvider),
                    child: const Text('Retry'),
                  ),
                ),
              ],
            );
          },
          data: (reminders) {
            if (reminders.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 96),
                  Center(child: Text('No reminders found.')),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: reminders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, index) {
                return ReminderTile(reminder: reminders[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
