class AppSettings {
  static const String weatherApiKey = String.fromEnvironment(
    'WEATHER_API_KEY',
    defaultValue: '',
  );

  static const String weatherApiBaseUrl =
      'https://api.openweathermap.org/data/2.5';

  static const String imageApiBaseUrl = String.fromEnvironment(
    'IMAGE_API_BASE_URL',
    defaultValue: '',
  );

  static bool get hasWeatherApiKey => weatherApiKey.isNotEmpty;

  static bool get hasImageApiBaseUrl => imageApiBaseUrl.isNotEmpty;
}
