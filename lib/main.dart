import 'package:flutter/material.dart';

import 'models/weather_data.dart';

void main() {
  runApp(const WeatherForecastAIApp());
}

class WeatherForecastAIApp extends StatelessWidget {
  const WeatherForecastAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeatherForecastAI',
      theme: ThemeData(useMaterial3: true),
      home: HomeScreen(weather: WeatherData.sampleKocaeli()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final WeatherData weather;

  const HomeScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7EC8E3), Color(0xFFEAF8FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  weather.cityName,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const WeatherIconBox(),
                const SizedBox(height: 16),
                Text(
                  weather.dateText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  weather.temperatureRange,
                  style: const TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  weather.conditionText,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 36),
                TodayDetailsCard(weather: weather),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherIconBox extends StatelessWidget {
  const WeatherIconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(40),
      ),
      child: const SizedBox(
        width: 130,
        height: 130,
        child: Icon(
          Icons.wb_cloudy_rounded,
          size: 82,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TodayDetailsCard extends StatelessWidget {
  final WeatherData weather;

  const TodayDetailsCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bugünün Detayları',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E3A5F),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: WeatherDetailCard(icon: Icons.water_drop_rounded, title: 'Nem', value: weather.humidity)),
                const SizedBox(width: 14),
                Expanded(child: WeatherDetailCard(icon: Icons.air_rounded, title: 'Rüzgar', value: weather.windSpeed)),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: WeatherDetailCard(icon: Icons.thermostat_rounded, title: 'Hissedilen', value: weather.feelsLike)),
                const SizedBox(width: 14),
                Expanded(child: WeatherDetailCard(icon: Icons.compress_rounded, title: 'Basınç', value: weather.pressure)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF4FAFF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF2F80ED), size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7A90),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF1E3A5F),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
