import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'subtypes/subtypes_routes.dart';
import 'generators/companion_routes/companion.dart';
import 'generators/companion_routes/companion_names.dart';
import 'generators/deities_routes/deities.dart';

// Configure routes.
final _router = Router()
  ..get("/subtypes/races", racesHandler)
  ..get("/subtypes/companions", companionsHandler)
  ..get("/subtypes/deities", deitiesHandler)
  ..get("/subtypes/governmentTypes", governmentTypeHandler)
  ..get("/subtypes/guilds", guildHandler)
  ..get("/subtypes/holidays", holidayHandler)
  ..get("/subtypes/landscapes", landscapeHandler)
  ..get("/subtypes/locations", locationHandler)
  ..get("/subtypes/settlements", settlementHandler)
  ..get("/subtypes/worldMapSettings", worldMapSettingsHandler)
  ..get("/generate/companion", generateCompanionHandler)
  ..get("/generate/companionNames", generateCompanionNamesHandler)
  ..get("/generate/deity", generateDeityHandler);

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
