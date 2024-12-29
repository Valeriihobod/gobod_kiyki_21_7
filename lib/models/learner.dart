import 'faculty.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import '../providers/faculty_provider.dart';

enum Sex { male, female }

class Learner {
  final String id;
  final String givenName;
  final String familyName;
  final Faculty faculty;
  final int score;
  final Sex sex;

  Learner({
    required this.id,
    required this.givenName,
    required this.familyName,
    required this.faculty,
    required this.score,
    required this.sex,
  });

  Learner.withId(
      {required this.id,
      required this.givenName,
      required this.familyName,
      required this.faculty,
      required this.sex,
      required this.score});

  Learner copyWith(givenName, familyName, faculty, identity, score) {
    return Learner.withId(
        id: id,
        givenName: givenName,
        familyName: familyName,
        faculty: faculty,
        sex: identity,
        score: score);
  }

  static Faculty getFacultyById(String id) {
    return predefinedFaculties.firstWhere(
      (department) => department.id == id,
      orElse: () => predefinedFaculties.first,
    );
  }



  static Future<List<Learner>> remoteGetList() async {
    final url = Uri.https(baseUrl, "$studentsPath.json");

    final response = await http.get(
      url,
    );

    if (response.statusCode >= 400) {
      throw Exception("Неможливо отримати список з Firebase");
    }

    if (response.body == "null") {
      return [];
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final List<Learner> loadedItems = [];
    for (final item in data.entries) {
      loadedItems.add(
        Learner(
          id: item.key,
          givenName: item.value['given_name']!,
          familyName: item.value['family_name']!,
          faculty: getFacultyById(item.value['faculty_id']!),
          sex: Sex.values.firstWhere((v) => v.toString() == item.value['sex']!),
          score: item.value['score']!,
        ),
      );
    }
    return loadedItems;
  }

  static Future<Learner> remoteCreate(
    givenName,
    familyName,
    facultyId,
    identity,
    score,
  ) async {

    final url = Uri.https(baseUrl, "$studentsPath.json");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'given_name': givenName!,
          'family_name': familyName,
          'faculty_id': facultyId,
          'sex': identity.toString(),
          'score': score,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't create a student");
    }

    final Map<String, dynamic> resData = json.decode(response.body);

    return Learner(
        id: resData['name'],
        givenName: givenName,
        familyName: familyName,
        faculty: getFacultyById(facultyId),
        sex: identity,
        score: score);
  }

  static Future remoteDelete(studentId) async {
    final url = Uri.https(baseUrl, "$studentsPath/$studentId.json");

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw Exception("Couldn't delete a student");
    }
  }

  static Future<Learner> remoteUpdate(
    studentId,
    givenName,
    familyName,
    facultyId,
    identity,
    score,
  ) async {
    final url = Uri.https(baseUrl, "$studentsPath/$studentId.json");

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'given_name': givenName!,
          'family_name': familyName,
          'faculty_id': facultyId,
          'sex': identity.toString(),
          'score': score,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't update a student");
    }

    return Learner(
        id: studentId,
        givenName: givenName,
        familyName: familyName,
        faculty: getFacultyById(facultyId),
        sex: identity,
        score: score);
  }
  
}