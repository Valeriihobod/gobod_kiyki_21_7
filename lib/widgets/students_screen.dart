import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {
  StudentsScreen({Key? key}) : super(key: key);

  final List<Student> students = [
    const Student(
      firstName: 'Emma',
      lastName: 'Johnson',
      department: Department.finance,
      grade: 95,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Liam',
      lastName: 'Smith',
      department: Department.it,
      grade: 88,
      gender: Gender.male,
    ),
    const Student(
      firstName: 'Sophia',
      lastName: 'Williams',
      department: Department.medical,
      grade: 90,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'James',
      lastName: 'Brown',
      department: Department.law,
      grade: 85,
      gender: Gender.male,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}