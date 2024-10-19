import 'dart:convert';

import 'package:randpg/entities/guilds.dart';
import 'package:randpg/generators.dart';
import 'package:shelf/shelf.dart';

Response generateGuildHandler(Request request) {
  try {
    final seedParam = request.url.queryParameters['seed'];
    final guildTypeParam = request.url.queryParameters['guildType'];
    final seed = int.tryParse(seedParam ?? "");

    final GuildType guildType;
    if (guildTypeParam != null) {
      guildType = GuildManager().getType(guildTypeParam);
    } else {
      final companionTypeGenerator =
          ListItemGenerator(GuildManager().activeTypes);
      if (seed != null) companionTypeGenerator.seed(seed);
      guildType = companionTypeGenerator.generate();
    }

    final generator = GuildGenerator(guildType);
    if (seed != null) generator.seed(seed + 1);

    final guild = generator.generate();
    final guildMap = guild.toMap();
    String encodedSvg = Uri.encodeComponent(guild.emblem.buildSvg());
    guildMap["emblem"] = "data:image/svg+xml;charset=utf-8,$encodedSvg";
    return Response.ok(
      jsonEncode(guildMap),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response(400, body: 'Error generating guild: ${e.toString()}');
  }
}
