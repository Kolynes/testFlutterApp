class ClientConfig{
  final String apiBaseUrl;

  ClientConfig(Map<String, dynamic> env)
      : apiBaseUrl = env['CLIENT_API_BASE_URL'] ?? 'https://jsonplaceholder.typicode.com';
}

class CollectionConfig {
  final String name;
  final String path;

  CollectionConfig(Map<String, dynamic> env)
      : name = env['HIVE_NAME'] ?? 'default_name',
        path = env['HIVE_PATH'] ?? '.';
}

class Config {
  final ClientConfig client;
  final CollectionConfig collection;

  Config({
    required this.client,
    required this.collection,
  });

  static Config instance(Map<String, dynamic> env) => Config(
    client: ClientConfig(env),
    collection: CollectionConfig(env),
  );
}