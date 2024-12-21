import 'package:flutter/material.dart';
import '../models/learner.dart';

class LearnerTile extends StatelessWidget {
  final Learner learner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LearnerTile({
    super.key,
    required this.learner,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          learner.faculty.symbol,
          size: 40,
          color: learner.sex == Sex.male ? Colors.blue : Colors.pink,
        ),
        title: Text(
          '${learner.givenName} ${learner.familyName}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Faculty: ${learner.faculty.title}'),
            Text('Evaluation: ${learner.score}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.create_outlined),
              onPressed: onEdit,
              color: Colors.teal, 
            ),
            IconButton(
              icon: const Icon(Icons.delete_forever_outlined),
              onPressed: onDelete,
              color: Colors.red, 
            ),
          ],
        ),
      ),
    );
  }
}
