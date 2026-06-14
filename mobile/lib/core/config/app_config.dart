enum AppEnvironment { development, staging, production }

class AppConfig {
  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool enableLogging;
  final bool useMockData;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    this.enableLogging = false,
    this.useMockData = true,
  });

  static AppConfig? _instance;

  static void init(AppConfig config) {
    _instance = config;
  }

  static AppConfig get instance {
    assert(_instance != null, 'AppConfig.init() must be called before accessing instance');
    return _instance!;
  }

  bool get isProduction => environment == AppEnvironment.production;
  bool get isDevelopment => environment == AppEnvironment.development;

  factory AppConfig.development() => const AppConfig(
        environment: AppEnvironment.development,
        apiBaseUrl: 'https://api-dev.banksatu.id/v1',
        enableLogging: true,
        useMockData: true,
      );

  factory AppConfig.staging() => const AppConfig(
        environment: AppEnvironment.staging,
        apiBaseUrl: 'https://api-staging.banksatu.id/v1',
        enableLogging: true,
        useMockData: true,
      );

  factory AppConfig.production() => const AppConfig(
        environment: AppEnvironment.production,
        apiBaseUrl: 'https://api.banksatu.id/v1',
        enableLogging: false,
        useMockData: false,
      );
}
