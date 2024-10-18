import 'dart:convert';
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
  });
}
