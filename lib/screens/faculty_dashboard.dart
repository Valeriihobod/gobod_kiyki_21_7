import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/faculty_provider.dart';
import '../providers/learner_provider.dart';
import '../widgets/faculty_card.dart';

class FacultyDashboard extends ConsumerWidget {
  const FacultyDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faculties = ref.watch(facultiesProvider);
    final learners = ref.watch(learnersProvider);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: faculties.length,
      itemBuilder: (context, index) {
        final faculty = faculties[index];
        final learnerCount = learners
            .where((learner) => learner.facultyId == faculty.id)
            .length;

        return FacultyCard(faculty: faculty, learnerCount: learnerCount);
      },
    );
  }
}
