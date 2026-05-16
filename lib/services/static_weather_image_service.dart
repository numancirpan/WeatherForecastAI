import 'package:flutter/services.dart';

import '../models/weather_data.dart';

class StaticWeatherImageService {
  static const Set<String> supportedCities = {
    'ankara',
    'bursa',
    'istanbul',
    'izmir',
    'kocaeli',
  };

  Future<String?> findAssetFor(WeatherData weather) async {
    final city = _normalizeCity(weather.cityName);
    final condition = _conditionSlug(weather.conditionCode);

    if (!supportedCities.contains(city)) {
      return null;
    }

    final path = 'assets/images/${city}_$condition.png';

    try {
      await rootBundle.load(path);
      return path;
    } catch (_) {
      return null;
    }
  }

  static String expectedAssetName(WeatherData weather) {
    final city = _normalizeCity(weather.cityName);
    final condition = _conditionSlug(weather.conditionCode);
    return '${city}_$condition.png';
  }

  static String _conditionSlug(String conditionCode) {
    switch (conditionCode) {
      case 'Clear':
        return 'clear';
      case 'Rain':
      case 'Drizzle':
      case 'Thunderstorm':
        return 'rain';
      case 'Snow':
        return 'snow';
      case 'Mist':
      case 'Fog':
      case 'Haze':
        return 'fog';
      default:
        return 'clouds';
    }
  }

  static String _normalizeCity(String cityName) {
    return cityName
        .trim()
        .toLowerCase()
        .replaceAll('ı', 'i')
        .replaceAll('ğ', 'g')
        .replaceAll('ü', 'u')
        .replaceAll('ş', 's')
        .replaceAll('ö', 'o')
        .replaceAll('ç', 'c')
        .replaceAll('İ', 'i')
        .replaceAll(RegExp(r'\s+'), '-');
  }
}
