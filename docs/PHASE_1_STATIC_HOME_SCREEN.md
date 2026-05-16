# Phase 1: Static Home Screen

This phase replaces the default Flutter counter app with a static weather home screen.

## 1. Open the Project

Open the repository folder in Visual Studio Code:

```bash
code .
```

## 2. Open `lib/main.dart`

Replace the entire content of `lib/main.dart` with the code below.

```dart
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
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
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
            colors: [
              Color(0xFF7EC8E3),
              Color(0xFFEAF8FF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Kocaeli',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.wb_cloudy_rounded,
                    size: 82,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '16 Mayıs 2026, Cumartesi',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '15° - 24°',
                  style: TextStyle(
                    fontSize: 54,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Parçalı Bulutlu',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 36),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Column(
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
                          Expanded(
                            child: WeatherDetailCard(
                              icon: Icons.water_drop_rounded,
                              title: 'Nem',
                              value: '%62',
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: WeatherDetailCard(
                              icon: Icons.air_rounded,
                              title: 'Rüzgar',
                              value: '12 km/h',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: WeatherDetailCard(
                              icon: Icons.thermostat_rounded,
                              title: 'Hissedilen',
                              value: '21°',
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: WeatherDetailCard(
                              icon: Icons.compress_rounded,
                              title: 'Basınç',
                              value: '1014 hPa',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FAFF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF2F80ED),
            size: 28,
          ),
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
    );
  }
}
```

## 3. Run the App

Save the file and run:

```bash
flutter run
```

If the app is already running, press `r` in the terminal for hot reload.

## 4. Expected Result

You should see a modern static Kocaeli weather screen instead of the default Flutter counter screen.

