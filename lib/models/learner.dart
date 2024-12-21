import 'faculty.dart';
import '../providers/faculty_provider.dart';

enum Sex { male, female }

class Learner {
  final String id;
  final String givenName;
  final String familyName;
  final String facultyId;
  final int score;
  final Sex sex;

  Learner({
    required this.id,
    required this.givenName,
    required this.familyName,
    required this.facultyId,
    required this.score,
    required this.sex,
  });

  Faculty get faculty =>
      predefinedFaculties.firstWhere((faculty) => faculty.id == facultyId);
}
