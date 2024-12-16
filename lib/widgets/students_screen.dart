import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';
import 'new_student.dart'; 

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student> students = [
    const Student(
      firstName: 'Alice',
      lastName: 'Brown',
      department: Department.law,
      grade: 85,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'John',
      lastName: 'Doe',
      department: Department.it,
      grade: 90,
      gender: Gender.male,
    ),
  ];

  void _addOrEditStudent({Student? student, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          student: student,
          onSave: (newStudent) {
            setState(() {
              if (index == null) {
                students.add(newStudent);
              } else {
                students[index] = newStudent;
              }
            });
          },
        );
      },
    );
  }

  void _deleteStudent(Student student, int index) {
    final removedStudent = students[index];
    setState(() => students.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Student removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() => students.insert(index, removedStudent));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Students',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Dismissible(
            key: ValueKey(student),
            background: Container(color: Colors.red),
            onDismissed: (_) => _deleteStudent(student, index),
            child: InkWell(
              onTap: () => _addOrEditStudent(student: student, index: index),
              child: StudentItem(student: student),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addOrEditStudent(),
        backgroundColor: Colors.orange,
        label: const Text('Add Student'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
