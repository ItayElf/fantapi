import 'dart:convert';

import 'package:randpg/entities/companions.dart';
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
