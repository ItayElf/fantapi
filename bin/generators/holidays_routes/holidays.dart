import 'package:randpg/entities/holidays.dart';
import 'package:randpg/generators.dart';
import 'package:shelf/shelf.dart';

Response generateHolidayHandler(Request request) {
  try {
    final seedParam = request.url.queryParameters['seed'];
    final holidayTypeParam = request.url.queryParameters['holidayType'];
    final seed = int.tryParse(seedParam ?? "");

    final HolidayType holidayType;
    if (holidayTypeParam != null) {
      holidayType = HolidayManager().getType(holidayTypeParam);
    } else {
      final companionTypeGenerator =
          ListItemGenerator(HolidayManager().activeTypes);
      if (seed != null) companionTypeGenerator.seed(seed);
      holidayType = companionTypeGenerator.generate();
    }

    final generator = HolidayGenerator(holidayType);
    if (seed != null) generator.seed(seed + 1);

    final holiday = generator.generate();
    return Response.ok(
      holiday.toJson(),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response(400, body: 'Error generating holiday: ${e.toString()}');
  }
}
