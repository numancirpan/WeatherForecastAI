import '../models/weather_data.dart';

class WeatherService {
  Future<WeatherData> getWeatherByCity(String cityName) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return WeatherData.sampleKocaeli();
  }
}
