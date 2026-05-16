import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_settings.dart';
import '../models/weather_data.dart';

class WeatherService {
  Future<WeatherData> getWeatherByCity(String cityName) async {
    if (!AppSettings.hasWeatherApiKey) {
      await Future.delayed(const Duration(milliseconds: 500));
      return WeatherData.sampleKocaeli();
    }

    final uri = Uri.parse('${AppSettings.weatherApiBaseUrl}/weather').replace(
      queryParameters: {
        'q': cityName,
        'appid': AppSettings.weatherApiKey,
        'units': 'metric',
        'lang': 'tr',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('API error: ${response.statusCode}');
    }

    final Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherData.fromOpenWeatherJson(json);
  }
}
