import 'dart:convert';
import 'package:randpg/entities/companions.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/races.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../bin/subtypes/subtypes_routes.dart';

void main() {
  group('Subtypes tests', () {
    test('Test get races', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/races'));
      final response = racesHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => RaceManager().getType(element), returnsNormally);
      }
      expect(jsonResponse.length, equals(RaceManager().activeTypes.length));
    });

    test('Test get companions', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/companions'));
      final response = companionsHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => CompanionManager().getType(element), returnsNormally);
      }
      expect(
          jsonResponse.length, equals(CompanionManager().activeTypes.length));
    });

    test('Test get deities', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/deities'));
      final response = deitiesHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => DeityManager().getType(element), returnsNormally);
      }
      expect(jsonResponse.length, equals(DeityManager().activeTypes.length));
    });
  });
}
