import 'dart:convert';

import 'package:randpg/entities/deities.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/generators/deities_routes/deities.dart';

void main() {
  group("Deity Generation Tests", () {
    test('Test generate deity with specific parameters', () async {
      final seed = 123;
      final deityType = God().getDeityType();
      final alignment = 'lawful good';
      final request = Request(
        'GET',
        Uri.parse(
          'http://localhost/generators/deity?seed=$seed&deityType=$deityType&alignment=$alignment',
        ),
      );

      final response = generateDeityHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody);
      expect(jsonResponse, isA<Map<String, dynamic>>());
      expect(() => DeityManager().getType(deityType), returnsNormally);
    });

    test('Test generate deity with random deityType and alignment', () async {
      final seed = 456;
      final request = Request(
        'GET',
        Uri.parse('http://localhost/generators/deity?seed=$seed'),
      );

      final response = generateDeityHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody);
      expect(jsonResponse, isA<Map<String, dynamic>>());
    });

    test('Test generate deity with invalid alignment', () async {
      final seed = 789;
      final invalidAlignment = 'InvalidAlignment';
      final request = Request(
        'GET',
        Uri.parse(
          'http://localhost/generators/deity?seed=$seed&alignment=$invalidAlignment',
        ),
      );

      final response = generateDeityHandler(request);
      expect(response.statusCode, equals(400));

      final responseBody = await response.readAsString();
      expect(responseBody, contains('Invalid alignment'));
    });

    test('Test generate deity with missing parameters', () async {
      final request = Request(
        'GET',
        Uri.parse('http://localhost/generators/deity'),
      );

      final response = generateDeityHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody);
      expect(jsonResponse, isA<Map<String, dynamic>>());
    });
  });
}
