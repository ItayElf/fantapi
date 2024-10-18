import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:randpg/entities/races.dart';

Response racesHandler(Request request) {
  return Response.ok(
    jsonEncode(RaceManager().activeTypes.map((r) => r.getName()).toList()),
    headers: {'Content-Type': 'application/json'},
  );
}
