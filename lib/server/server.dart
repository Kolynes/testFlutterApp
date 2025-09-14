import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
	final scriptDir = p.dirname(Platform.script.toFilePath());
	final dataFile = File(p.join(scriptDir, 'data.json'));
	final data = await dataFile.readAsString();
	final businesses = jsonDecode(data);


		final handler = Pipeline()
				.addMiddleware(logRequests())
				.addMiddleware(corsHeaders())
				.addHandler((Request request) {
			if (request.url.path == 'businesses') {
				return Response.ok(jsonEncode(businesses), headers: {
					'Content-Type': 'application/json',
				});
			}
			return Response.notFound('Not Found');
		});

	final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
	final server = await shelf_io.serve(handler, 'localhost', port);
	print('Serving at http://${server.address.host}:${server.port}');
}
