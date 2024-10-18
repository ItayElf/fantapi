import 'dart:convert';

import 'package:randpg/entities/companions.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/holidays.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/world_map.dart';
import 'package:shelf/shelf.dart';
import 'package:randpg/entities/races.dart';

Response racesHandler(Request request) {
  return Response.ok(
    jsonEncode(RaceManager().activeTypes.map((r) => r.getName()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response companionsHandler(Request request) {
  return Response.ok(
    jsonEncode(CompanionManager()
        .activeTypes
        .map((r) => r.getCompanionType())
        .toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response deitiesHandler(Request request) {
  return Response.ok(
    jsonEncode(
        DeityManager().activeTypes.map((r) => r.getDeityType()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response governmentTypeHandler(Request request) {
  return Response.ok(
    jsonEncode(GovernmentTypeManager()
        .activeTypes
        .map((r) => r.getGovernmentType())
        .toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response guildHandler(Request request) {
  return Response.ok(
    jsonEncode(
        GuildManager().activeTypes.map((r) => r.getGuildType()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response holidayHandler(Request request) {
  return Response.ok(
    jsonEncode(
        HolidayManager().activeTypes.map((r) => r.getHolidayType()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response landscapeHandler(Request request) {
  return Response.ok(
    jsonEncode(LandscapeManager()
        .activeTypes
        .map((r) => r.getLandscapeType())
        .toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response locationHandler(Request request) {
  return Response.ok(
    jsonEncode(
        LocationManager().activeTypes.map((r) => r.getLocationType()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response settlementHandler(Request request) {
  return Response.ok(
    jsonEncode(SettlementManager()
        .activeTypes
        .map((r) => r.getSettlementType())
        .toList()),
    headers: {'Content-Type': 'application/json'},
  );
}

Response worldMapSettingsHandler(Request request) {
  return Response.ok(
    jsonEncode(WorldMapSettingsManager()
        .activeTypes
        .map((r) => r.getSettingName())
        .toList()),
    headers: {'Content-Type': 'application/json'},
  );
}
