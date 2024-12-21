import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/learner_provider.dart';
import '../widgets/learner_tile.dart';
import '../widgets/learner_form.dart';

class LearnerList extends ConsumerWidget {
  const LearnerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learners = ref.watch(learnersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learners'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => LearnerForm(
                onSave: (newLearner) {
                  ref.read(learnersProvider.notifier).addLearner(newLearner);
                },
              ),
            );
          },
        ),
      ),
      body: learners.isEmpty
          ? const Center(child: Text('No learners available'))
          : ListView.builder(
              itemCount: learners.length,
              itemBuilder: (context, index) {
                final learner = learners[index];
                return Dismissible(
                  key: ValueKey(learner.id),
                  background: Container(color: Colors.red),
                  onDismissed: (_) =>
                      ref.read(learnersProvider.notifier).removeLearner(index),
                  child: LearnerTile(
                    learner: learner,
                    onEdit: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => LearnerForm(
                          learner: learner,
                          onSave: (updatedLearner) {
                            ref
                                .read(learnersProvider.notifier)
                                .updateLearner(index, updatedLearner);
                          },
                        ),
                      );
                    },
                    onDelete: () {
                      ref.read(learnersProvider.notifier).removeLearner(index);
                      final container = ProviderScope.containerOf(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${learner.givenName} removed'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              container
                                  .read(learnersProvider.notifier)
                                  .undoRemove();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
