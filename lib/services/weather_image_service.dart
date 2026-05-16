import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_settings.dart';
import '../models/weather_data.dart';
import '../models/weather_image.dart';

class WeatherImageService {
  Future<WeatherImage?> getOrCreateImage(WeatherData weather) async {
    if (!AppSettings.hasImageApiBaseUrl) {
      return null;
    }

    final uri = Uri.parse('${AppSettings.imageApiBaseUrl}/weather-images')
        .replace(
          queryParameters: {
            'city': weather.cityName,
            'condition': weather.conditionCode,
            'period': _timePeriod(DateTime.now()),
            'minTemp': weather.minTemperature.toString(),
            'maxTemp': weather.maxTemperature.toString(),
            'date': weather.dateText,
            'conditionText': weather.conditionText,
          },
        );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return null;
    }

    final Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherImage.fromJson(json);
  }

  static String buildPrompt(WeatherData weather) {
    return '''
Create a vertical 9:16 mobile weather app hero illustration for the city of ${weather.cityName}.

Use a clear 45-degree top-down isometric miniature 3D cartoon style. Show iconic and recognizable landmarks of ${weather.cityName}. Integrate the current weather condition creatively into the city architecture and atmosphere.

Weather data:
City: ${weather.cityName}
Date: ${weather.dateText}
Condition: ${weather.conditionText}
Temperature range: ${weather.temperatureRange}

Visual style:
- Soft, refined textures.
- Realistic PBR-like materials.
- Gentle realistic lighting and soft shadows.
- Fresh, calming, minimalist aesthetic.
- Smooth flat-color background.
- Clean unified composition.
- High-detail miniature city modeling.
- No clutter.
- No text, numbers, labels, logos, watermark, or UI typography in the image.
- Leave clean empty space at the top for Flutter UI overlay.
''';
  }

  static String cacheKeyFor(WeatherData weather) {
    final city = weather.cityName.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      '-',
    );
    final condition = weather.conditionCode.trim().toLowerCase();
    return '$city-$condition-${_timePeriod(DateTime.now())}';
  }

  static String _timePeriod(DateTime date) {
    final hour = date.hour;
    if (hour >= 20 || hour < 6) return 'night';
    if (hour < 11) return 'morning';
    if (hour < 17) return 'day';
    return 'evening';
  }
}
