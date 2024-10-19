import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../../bin/generators/emblem_routes/emblems.dart';

void main() {
  group("Emblem Generation Tests", () {
    test('Test generate emblem with seed', () async {
      final request = Request(
        'GET',
        Uri.parse('http://localhost/generators/emblem?seed=12345'),
      );

      final response = generateEmblemHandler(request);

      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('image/svg+xml'));

      final responseBody = await response.readAsString();
      expect(responseBody,
          contains('<svg')); // Ensure the response contains an SVG tag
    });

    test('Test generate emblem without seed', () async {
      final request =
          Request('GET', Uri.parse('http://localhost/generators/emblem'));

      final response = generateEmblemHandler(request);

      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('image/svg+xml'));

      final responseBody = await response.readAsString();
      expect(responseBody,
          contains('<svg')); // Ensure the response contains an SVG tag
    });
  });
}
