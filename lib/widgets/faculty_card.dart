import 'package:flutter/material.dart';
import '../models/faculty.dart';

class FacultyCard extends StatelessWidget {
  final Faculty faculty;
  final int learnerCount;

  const FacultyCard({
    super.key,
    required this.faculty,
    required this.learnerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [faculty.tone.withOpacity(0.6), faculty.tone],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(faculty.symbol, size: 40, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            faculty.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '$learnerCount Learners',
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
