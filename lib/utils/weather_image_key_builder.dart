class WeatherImageKeyBuilder {
  String buildKey({
    required String cityName,
    required String condition,
    required String timePeriod,
    required String season,
  }) {
    final city = _normalize(cityName);
    final weather = _normalize(condition);
    final time = _normalize(timePeriod);
    final seasonValue = _normalize(season);

    return '${city}_${weather}_${time}_$seasonValue';
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('ı', 'i')
        .replaceAll('ğ', 'g')
        .replaceAll('ü', 'u')
        .replaceAll('ş', 's')
        .replaceAll('ö', 'o')
        .replaceAll('ç', 'c')
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
  }
}
