class WeatherData {
  final String cityName;
  final String dateText;
  final String conditionText;
  final String temperatureRange;
  final String humidity;
  final String windSpeed;
  final String feelsLike;
  final String pressure;

  const WeatherData({
    required this.cityName,
    required this.dateText,
    required this.conditionText,
    required this.temperatureRange,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required this.pressure,
  });

  factory WeatherData.sampleKocaeli() {
    return const WeatherData(
      cityName: 'Kocaeli',
      dateText: '16 Mayıs 2026, Cumartesi',
      conditionText: 'Parçalı Bulutlu',
      temperatureRange: '15° - 24°',
      humidity: '%62',
      windSpeed: '12 km/h',
      feelsLike: '21°',
      pressure: '1014 hPa',
    );
  }
}
