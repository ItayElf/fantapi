import 'dart:convert';
import 'package:randpg/entities/companions.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/holidays.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/world_map.dart';
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

    test('Test get government types', () async {
      final request = Request(
          'GET', Uri.parse('http://localhost/subtypes/governmentTypes'));
      final response = governmentTypeHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => GovernmentTypeManager().getType(element), returnsNormally);
      }
      expect(jsonResponse.length,
          equals(GovernmentTypeManager().activeTypes.length));
    });

    test('Test get guild types', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/guilds'));
      final response = guildHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => GuildManager().getType(element), returnsNormally);
      }
      expect(jsonResponse.length, equals(GuildManager().activeTypes.length));
    });

    test('Test get holidays', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/holidays'));
      final response = holidayHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => HolidayManager().getType(element), returnsNormally);
      }
      expect(jsonResponse.length, equals(HolidayManager().activeTypes.length));
    });

    test('Test get landscapes', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/landscapes'));
      final response = landscapeHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => LandscapeManager().getType(element), returnsNormally);
      }
      expect(
          jsonResponse.length, equals(LandscapeManager().activeTypes.length));
    });

    test('Test get locations', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/locations'));
      final response = locationHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => LocationManager().getType(element), returnsNormally);
      }
      expect(jsonResponse.length, equals(LocationManager().activeTypes.length));
    });

    test('Test get settlements', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/subtypes/settlements'));
      final response = settlementHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(() => SettlementManager().getType(element), returnsNormally);
      }
      expect(
          jsonResponse.length, equals(SettlementManager().activeTypes.length));
    });

    test('Test get world map settings', () async {
      final request = Request(
          'GET', Uri.parse('http://localhost/subtypes/worldMapSettings'));
      final response = worldMapSettingsHandler(request);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('application/json'));

      final responseBody = await response.readAsString();
      final jsonResponse = jsonDecode(responseBody) as List;
      for (var element in jsonResponse) {
        expect(
            () => WorldMapSettingsManager().getType(element), returnsNormally);
      }
      expect(jsonResponse.length,
          equals(WorldMapSettingsManager().activeTypes.length));
    });
  });
}
