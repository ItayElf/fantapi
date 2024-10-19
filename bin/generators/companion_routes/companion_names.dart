import 'dart:convert';

import 'package:randpg/entities/companions.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/generators.dart';
import 'package:shelf/shelf.dart';

Response generateCompanionNamesHandler(Request request) {
  try {
    final seedParam = request.url.queryParameters['seed'];
    final companionTypeParam = request.url.queryParameters['companionType'];
    final genderParam = request.url.queryParameters['gender'];
    final countParam = request.url.queryParameters['count'];
    final seed = int.tryParse(seedParam ?? "");
    final count = int.tryParse(countParam ?? "") ?? 10;

    final CompanionType companionType;
    if (companionTypeParam != null) {
      companionType = CompanionManager().getType(companionTypeParam);
    } else {
      final companionTypeGenerator =
          ListItemGenerator(CompanionManager().activeTypes);
      if (seed != null) companionTypeGenerator.seed(seed);
      companionType = companionTypeGenerator.generate();
    }

    final Gender gender;
    if (genderParam != null) {
      gender = Gender.values.firstWhere(
        (e) => e.name == genderParam,
        orElse: () => throw ArgumentError('Invalid gender name: $genderParam'),
      );
    } else {
      final genderGenerator = ListItemGenerator(Gender.values);
      if (seed != null) genderGenerator.seed(seed + 1);
      gender = genderGenerator.generate();
    }

    final generator = UniqueGenerator(
      companionType.getNameGenerator(gender),
      count,
    );
    if (seed != null) generator.seed(seed + 2);

    final companionNames = generator.generate();
    return Response.ok(
      jsonEncode(companionNames),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response(400,
        body: 'Error generating companion names: ${e.toString()}');
  }
}
