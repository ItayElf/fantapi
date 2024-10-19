import 'dart:convert';

import 'package:randpg/entities/companions.dart';
import 'package:randpg/enums/gender.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/generators/companion_routes/companion.dart';

void main() {
  test('Test generate companion with valid parameters', () async {
    final seed = 123;
    final companionType = Dog().getCompanionType();
    final gender = Gender.male.name;

    final request = Request(
      'GET',
      Uri.parse(
          'http://localhost/generateCompanion?seed=$seed&companionType=$companionType&gender=$gender'),
    );

    final response = generateCompanionHandler(request);
    expect(response.statusCode, equals(200));
    expect(response.headers['Content-Type'], equals('application/json'));

    final responseBody = await response.readAsString();
    final jsonResponse = jsonDecode(responseBody);
    expect(() => Companion.fromMap(jsonResponse), returnsNormally);

    expect(Companion.fromMap(jsonResponse).companionType.getCompanionType(),
        equals(companionType));
    expect(Companion.fromMap(jsonResponse).gender.name, equals(gender));
  });

  test('Test generate companion with missing parameters', () async {
    final seed = 123;

    final request = Request(
      'GET',
      Uri.parse('http://localhost/generateCompanion?seed=$seed'),
    );

    final response = generateCompanionHandler(request);
    expect(response.statusCode, equals(200));
    expect(response.headers['Content-Type'], equals('application/json'));

    final responseBody = await response.readAsString();
    final jsonResponse = jsonDecode(responseBody);
    expect(jsonResponse, isA<Map<String, dynamic>>());

    // Additional checks if needed
  });

  test('Test generate companion with invalid parameters', () async {
    final seed = 123;
    final invalidGender = 'invalidGender'; // Invalid gender

    final request = Request(
      'GET',
      Uri.parse(
          'http://localhost/generateCompanion?seed=$seed&gender=$invalidGender'),
    );

    final response = generateCompanionHandler(request);
    expect(response.statusCode, equals(400));

    final responseBody = await response.readAsString();
    expect(responseBody, contains('Invalid gender name'));
  });
}
