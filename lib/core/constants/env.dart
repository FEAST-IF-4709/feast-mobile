/// Base URL for the FEAST backend API.
///
/// Override at build time with --dart-define:
///   flutter run --dart-define=API_BASE_URL=http://192.168.x.x:8000
///
/// Default targets Android emulator → host machine via 10.0.2.2.
/// For web or iOS Simulator: flutter run --dart-define=API_BASE_URL=http://localhost:8000
const String kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://192.168.18.17:8000',
);
