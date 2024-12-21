import 'package:flutter/material.dart';
import '../models/learner.dart';
import '../providers/faculty_provider.dart';
import 'package:uuid/uuid.dart';

class LearnerForm extends StatefulWidget {
  final Learner? learner;
  final Function(Learner) onSave;

  const LearnerForm({super.key, this.learner, required this.onSave});

  @override
  _LearnerFormState createState() => _LearnerFormState();
}

class _LearnerFormState extends State<LearnerForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _selectedFacultyId;
  Sex? _selectedSex;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    if (widget.learner != null) {
      _firstNameController.text = widget.learner!.givenName;
      _lastNameController.text = widget.learner!.familyName;
      _selectedFacultyId = widget.learner!.facultyId;
      _selectedSex = widget.learner!.sex;
      _score = widget.learner!.score;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveLearner() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _selectedFacultyId == null ||
        _selectedSex == null) {
      return;
    }

    final newLearner = Learner(
      id: widget.learner?.id ?? const Uuid().v4(),
      givenName: _firstNameController.text.trim(),
      familyName: _lastNameController.text.trim(),
      facultyId: _selectedFacultyId!,
      score: _score,
      sex: _selectedSex!,
    );

    widget.onSave(newLearner);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Learner Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedFacultyId,
                    decoration: InputDecoration(
                      labelText: 'Faculty',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: predefinedFaculties.map((faculty) {
                      return DropdownMenuItem(
                        value: faculty.id,
                        child: Row(
                          children: [
                            Icon(faculty.symbol, size: 20),
                            const SizedBox(width: 10),
                            Text(faculty.title),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedFacultyId = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<Sex>(
                    value: _selectedSex,
                    decoration: InputDecoration(
                      labelText: 'Sex',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: Sex.values.map((sex) {
                      return DropdownMenuItem(
                        value: sex,
                        child: Text(sex.toString().split('.').last.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedSex = value),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Score: $_score',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Slider(
                        value: _score.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: '$_score',
                        activeColor: Colors.teal,
                        onChanged: (value) => setState(() => _score = value.toInt()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        label: const Text('Cancel'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _saveLearner,
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: Text(widget.learner == null ? 'Save' : 'Update'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
