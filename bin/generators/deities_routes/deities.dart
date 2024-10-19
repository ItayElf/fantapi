import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/enums/alignment.dart';
import 'package:randpg/generators.dart';
import 'package:shelf/shelf.dart';

const _alignments = {
  "lawful good": Alignment(
    ethical: EthicalAlignment.lawful,
    moral: MoralAlignment.good,
  ),
  "neutral good": Alignment(
    ethical: EthicalAlignment.ethicalTrue,
    moral: MoralAlignment.good,
  ),
  "chaotic good": Alignment(
    ethical: EthicalAlignment.chaotic,
    moral: MoralAlignment.good,
  ),
  "lawful neutral": Alignment(
    ethical: EthicalAlignment.lawful,
    moral: MoralAlignment.neutral,
  ),
  "neutral": Alignment(
    ethical: EthicalAlignment.ethicalTrue,
    moral: MoralAlignment.neutral,
  ),
  "chaotic neutral": Alignment(
    ethical: EthicalAlignment.chaotic,
    moral: MoralAlignment.neutral,
  ),
  "lawful evil": Alignment(
    ethical: EthicalAlignment.lawful,
    moral: MoralAlignment.evil,
  ),
  "neutral evil": Alignment(
    ethical: EthicalAlignment.ethicalTrue,
    moral: MoralAlignment.evil,
  ),
  "chaotic evil": Alignment(
    ethical: EthicalAlignment.chaotic,
    moral: MoralAlignment.evil,
  ),
  "unaligned": null,
};

Response generateDeityHandler(Request request) {
  try {
    final seedParam = request.url.queryParameters['seed'];
    final deityTypeParam = request.url.queryParameters['deityType'];
    final alignmentParam = request.url.queryParameters['alignment'];
    final seed = int.tryParse(seedParam ?? "");

    final DeityType deityType;
    if (deityTypeParam != null) {
      deityType = DeityManager().getType(deityTypeParam);
    } else {
      final companionTypeGenerator =
          ListItemGenerator(DeityManager().activeTypes);
      if (seed != null) companionTypeGenerator.seed(seed);
      deityType = companionTypeGenerator.generate();
    }

    final Alignment? alignment;
    if (alignmentParam != null) {
      if (_alignments.containsKey(alignmentParam.toLowerCase())) {
        alignment = _alignments[alignmentParam.toLowerCase()];
      } else {
        throw ArgumentError(
            'Invalid alignment. Available alignments: ${_alignments.values.join(", ")}');
      }
    } else {
      final alignmentGenerator = ListItemGenerator(_alignments.values.toList());
      if (seed != null) alignmentGenerator.seed(seed + 1);
      alignment = alignmentGenerator.generate();
    }

    final generator = DeityGenerator(deityType, alignment);
    if (seed != null) generator.seed(seed + 2);

    final deity = generator.generate();
    return Response.ok(
      deity.toJson(),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response(400, body: 'Error generating companion: ${e.toString()}');
  }
}
