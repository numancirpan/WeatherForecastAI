class AppSettings {
  static const String weatherApiKey = String.fromEnvironment(
    'WEATHER_API_KEY',
    defaultValue: '',
  );

  static const String weatherApiBaseUrl = 'https://api.openweathermap.org/data/2.5';

  static bool get hasWeatherApiKey => weatherApiKey.isNotEmpty;
}
