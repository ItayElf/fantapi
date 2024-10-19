import 'package:randpg/entities/emblems.dart';
import 'package:shelf/shelf.dart';

Response generateEmblemHandler(Request request) {
  try {
    final seedParam = request.url.queryParameters['seed'];
    final seed = int.tryParse(seedParam ?? "");

    final generator = EmblemGenerator(DefaultEmblemType());
    if (seed != null) generator.seed(seed + 2);

    final emblem = generator.generate();
    return Response.ok(
      emblem.buildSvg(),
      headers: {'Content-Type': 'image/svg+xml'},
    );
  } catch (e) {
    return Response(400, body: 'Error generating emblem: ${e.toString()}');
  }
}
