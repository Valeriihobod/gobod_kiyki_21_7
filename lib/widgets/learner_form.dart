import 'package:flutter/material.dart';
import '../models/learner.dart';
import '../providers/faculty_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/learner_provider.dart';

class LearnerForm extends ConsumerStatefulWidget {
  const LearnerForm({
    super.key,
    this.learnerIndex
  });

  final int? learnerIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LearnerFormState();
}

class _LearnerFormState extends ConsumerState<LearnerForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String _selectedFacultyId = predefinedFaculties[0].id;
  Sex _selectedSex = Sex.male;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    if (widget.learnerIndex != null) {
      final student = ref.read(learnersProvider).learners[widget.learnerIndex!];
      _firstNameController.text = student.givenName;
      _lastNameController.text = student.familyName;
      _selectedSex = student.sex;
      _selectedFacultyId = student.faculty.id;
      _score = student.score;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveLearner() async {
    if (widget.learnerIndex == null)  {
      await ref.read(learnersProvider.notifier).addLearner(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedFacultyId,
            _selectedSex,
            _score,
          );
    } else {
      await ref.read(learnersProvider.notifier).updateLearner(
            widget.learnerIndex!,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedFacultyId,
            _selectedSex,
            _score,
          );
    }

    if (!context.mounted) return;
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    final learnersState = ref.watch(learnersProvider);
    if (learnersState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
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
                    onChanged: (value) => setState(() => _selectedFacultyId = value!),
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
                    onChanged: (value) => setState(() => _selectedSex = value!),
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
                        label: Text(widget.learnerIndex == null ? 'Save' : 'Update'),
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
