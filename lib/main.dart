import 'package:flutter/material.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  'Kocaeli',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                WeatherIconBox(),
                SizedBox(height: 16),
                Text(
                  '16 Mayıs 2026, Cumartesi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '15° - 24°',
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Parçalı Bulutlu',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 36),
                TodayDetailsCard(),
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
  const TodayDetailsCard({super.key});

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
      child: const Padding(
        padding: EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bugünün Detayları',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E3A5F),
              ),
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: WeatherDetailCard(icon: Icons.water_drop_rounded, title: 'Nem', value: '%62')),
                SizedBox(width: 14),
                Expanded(child: WeatherDetailCard(icon: Icons.air_rounded, title: 'Rüzgar', value: '12 km/h')),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: WeatherDetailCard(icon: Icons.thermostat_rounded, title: 'Hissedilen', value: '21°')),
                SizedBox(width: 14),
                Expanded(child: WeatherDetailCard(icon: Icons.compress_rounded, title: 'Basınç', value: '1014 hPa')),
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
