import 'dart:convert';
import 'package:randpg/entities/guilds.dart';
import 'package:test/test.dart';
import 'package:shelf/shelf.dart';

// Assuming the `generateGuildHandler` is defined in your application
import '../../bin/generators/guilds_routes/guilds.dart';

void main() {
  test('Test generateGuildHandler without parameters', () async {
    final request =
        Request('GET', Uri.parse('http://localhost/generate/guild'));
    final response = generateGuildHandler(request);

    expect(response.statusCode, equals(200));
    expect(response.headers['Content-Type'], equals('application/json'));

    final responseBody = await response.readAsString();
    final jsonResponse = jsonDecode(responseBody);

    expect(jsonResponse, isNotNull);
    expect(jsonResponse, isA<Map>());
    expect(() => Guild.fromMap(jsonResponse), returnsNormally);
  });

  test('Test generateGuildHandler with seed and guildType parameters',
      () async {
    final guildTypeParam = ThievesGuild().getGuildType();
    final request = Request(
      'GET',
      Uri.parse(
        'http://localhost/generate/guild?seed=12345&guildType=$guildTypeParam',
      ),
    );
    final response = generateGuildHandler(request);

    expect(response.statusCode, equals(200));
    expect(response.headers['Content-Type'], equals('application/json'));

    final responseBody = await response.readAsString();
    final jsonResponse = jsonDecode(responseBody);

    expect(jsonResponse, isNotNull);
    expect(jsonResponse, isA<Map>());
    expect(() => Guild.fromMap(jsonResponse), returnsNormally);
    expect(Guild.fromMap(jsonResponse).guildType, isA<ThievesGuild>());
  });

  test('Test generateGuildHandler with invalid guildType parameter', () async {
    final request = Request('GET',
        Uri.parse('http://localhost/generate/guild?guildType=InvalidType'));
    final response = generateGuildHandler(request);

    expect(response.statusCode, equals(400));
    final responseBody = await response.readAsString();
    expect(responseBody, contains('Error generating guild'));
  });
}
