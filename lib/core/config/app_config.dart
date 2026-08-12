/// Environment types for MASARI platform
enum Environment { dev, staging, prod }

/// MASARI Application Configuration Engine.
/// Manages environment settings, API base URLs, feature flags, and secure configurations.
class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final String firebaseProjectId;
  final bool enableAuditLogging;
  final bool enableSecureStorage;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.firebaseProjectId,
    this.enableAuditLogging = true,
    this.enableSecureStorage = true,
  });

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static void initialize({required Environment environment}) {
    switch (environment) {
      case Environment.dev:
        _instance = const AppConfig(
          environment: Environment.dev,
          apiBaseUrl: 'https://api-dev.masari.travel',
          firebaseProjectId: 'masari-dev-app',
        );
        break;
      case Environment.staging:
        _instance = const AppConfig(
          environment: Environment.staging,
          apiBaseUrl: 'https://api-staging.masari.travel',
          firebaseProjectId: 'masari-staging-app',
        );
        break;
      case Environment.prod:
        _instance = const AppConfig(
          environment: Environment.prod,
          apiBaseUrl: 'https://api.masari.travel',
          firebaseProjectId: 'masari-prod-app',
        );
        break;
    }
  }

  bool get isProduction => environment == Environment.prod;
}
