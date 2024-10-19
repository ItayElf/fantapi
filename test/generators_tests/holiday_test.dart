import 'package:randpg/entities/holidays.dart';
import 'package:test/test.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert';
import '../../bin/generators/holidays_routes/holidays.dart';

void main() {
  group('Holiday Generation Tests', () {
    test('Generate holiday without seed or type', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/generate/holiday'));
      final response = generateHolidayHandler(request);

      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody);

      expect(jsonResponse, isNotEmpty);
      expect(() => Holiday.fromMap(jsonResponse), returnsNormally);
    });

    test('Generate holiday with seed', () async {
      final request = Request(
          'GET', Uri.parse('http://localhost/generate/holiday?seed=1234'));
      final response = generateHolidayHandler(request);

      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody);

      expect(jsonResponse, isNotEmpty);
    });

    test('Generate holiday with specific holidayType', () async {
      final holidayType = Celebration().getHolidayType();
      final request = Request(
          'GET',
          Uri.parse(
              'http://localhost/generate/holiday?holidayType=$holidayType'));
      final response = generateHolidayHandler(request);

      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody);

      expect(jsonResponse, isNotEmpty);
    });

    test('Generate holiday with invalid holidayType', () async {
      final request = Request(
          'GET',
          Uri.parse(
              'http://localhost/generate/holiday?holidayType=invalidType'));
      final response = generateHolidayHandler(request);

      expect(response.statusCode, equals(400));
      final responseBody = await response.readAsString();
      expect(responseBody, contains('Error generating holiday'));
    });
  });
}
