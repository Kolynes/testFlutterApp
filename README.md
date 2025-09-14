# test_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


## Running the Internal Server (for data.json)

To serve the `data.json` file locally (used for business data), run the Dart server included in this project:

1. Open a terminal and navigate to the project root.
2. Run:

	```sh
	dart lib/server/server.dart
	```

3. The server will start on http://localhost:8080 by default.
	- Access the business data at: http://localhost:8080/businesses

**Note:**
- Ensure you have Dart installed (https://dart.dev/get-dart).
- The server reads `lib/server/data.json` and supports CORS for local development.
