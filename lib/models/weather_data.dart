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

  factory WeatherData.fromOpenWeatherJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>?;
    final weatherList = json['weather'] as List<dynamic>;
    final weather = weatherList.first as Map<String, dynamic>;

    final tempMin = (main['temp_min'] as num).round();
    final tempMax = (main['temp_max'] as num).round();
    final humidityValue = main['humidity'] as num;
    final feelsLikeValue = (main['feels_like'] as num).round();
    final pressureValue = main['pressure'] as num;
    final windSpeedValue = ((wind?['speed'] as num?) ?? 0) * 3.6;

    return WeatherData(
      cityName: json['name'] as String? ?? 'Bilinmeyen Şehir',
      dateText: _formatTurkishDate(DateTime.now()),
      conditionText: _capitalize(weather['description'] as String? ?? 'Bilinmiyor'),
      temperatureRange: '$tempMin° - $tempMax°',
      humidity: '%${humidityValue.round()}',
      windSpeed: '${windSpeedValue.round()} km/h',
      feelsLike: '$feelsLikeValue°',
      pressure: '${pressureValue.round()} hPa',
    );
  }

  static String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  static String _formatTurkishDate(DateTime date) {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];

    const weekdays = [
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi',
      'Pazar',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}, ${weekdays[date.weekday - 1]}';
  }
}
