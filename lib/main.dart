import 'package:flutter/material.dart';

import 'models/weather_data.dart';
import 'models/weather_visual.dart';
import 'services/static_weather_image_service.dart';
import 'services/weather_image_service.dart';
import 'services/weather_service.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2478A6)),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  final WeatherImageService _imageService = WeatherImageService();
  final StaticWeatherImageService _staticImageService =
      StaticWeatherImageService();
  final TextEditingController _cityController = TextEditingController(
    text: 'Kocaeli',
  );
  late Future<WeatherData> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = _weatherService.getWeatherByCity('Kocaeli');
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _searchCity() {
    final cityName = _cityController.text.trim();

    if (cityName.isEmpty) {
      return;
    }

    setState(() {
      _weatherFuture = _weatherService.getWeatherByCity(cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherData>(
      future: _weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WeatherShell(
            cityController: _cityController,
            onSearch: _searchCity,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasError) {
          return WeatherShell(
            cityController: _cityController,
            onSearch: _searchCity,
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        }

        final weather = snapshot.data ?? WeatherData.sampleKocaeli();
        return WeatherShell(
          cityController: _cityController,
          onSearch: _searchCity,
          child: WeatherHomeContent(
            weather: weather,
            visualFuture: _getWeatherVisual(weather),
          ),
        );
      },
    );
  }

  Future<WeatherVisual> _getWeatherVisual(WeatherData weather) async {
    final assetPath = await _staticImageService.findAssetFor(weather);
    if (assetPath != null) {
      return WeatherVisual.asset(assetPath);
    }

    final generatedImage = await _imageService.getOrCreateImage(weather);
    if (generatedImage != null && generatedImage.imageUrl.isNotEmpty) {
      return WeatherVisual.network(generatedImage.imageUrl);
    }

    return const WeatherVisual.fallback();
  }
}

class WeatherShell extends StatelessWidget {
  final TextEditingController cityController;
  final VoidCallback onSearch;
  final Widget child;

  const WeatherShell({
    super.key,
    required this.cityController,
    required this.onSearch,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5FB4C9), Color(0xFFF7EEE1), Color(0xFFEAF8FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 18, 14, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    CitySearchBar(
                      controller: cityController,
                      onSearch: onSearch,
                    ),
                    const SizedBox(height: 14),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CitySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const CitySearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => onSearch(),
            decoration: InputDecoration(
              hintText: 'Şehir ara',
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.92),
              prefixIcon: const Icon(Icons.location_city_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton.filled(
          onPressed: onSearch,
          icon: const Icon(Icons.search_rounded),
          tooltip: 'Ara',
        ),
      ],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Hava durumu bilgisi alınamadı.\n$message',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xFF1E3A5F)),
      ),
    );
  }
}

class WeatherHomeContent extends StatelessWidget {
  final WeatherData weather;
  final Future<WeatherVisual> visualFuture;

  const WeatherHomeContent({
    super.key,
    required this.weather,
    required this.visualFuture,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherHeroCard(weather: weather, visualFuture: visualFuture),
        const SizedBox(height: 18),
        TodayDetailsCard(weather: weather),
        const SizedBox(height: 18),
        ImageCacheInfo(weather: weather),
      ],
    );
  }
}

class WeatherHeroCard extends StatelessWidget {
  final WeatherData weather;
  final Future<WeatherVisual> visualFuture;

  const WeatherHeroCard({
    super.key,
    required this.weather,
    required this.visualFuture,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.72,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            FutureBuilder<WeatherVisual>(
              future: visualFuture,
              builder: (context, snapshot) {
                final visual = snapshot.data;
                if (visual != null && visual.hasAsset) {
                  return Image.asset(
                    visual.assetPath!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        WeatherIllustrationFallback(
                          condition: weather.conditionCode,
                        ),
                  );
                }

                if (visual != null && visual.hasNetwork) {
                  return Image.network(
                    visual.networkUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        WeatherIllustrationFallback(
                          condition: weather.conditionCode,
                        ),
                  );
                }

                return WeatherIllustrationFallback(
                  condition: weather.conditionCode,
                );
              },
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xAA1D3B4D),
                    Color(0x331D3B4D),
                    Color(0x551D3B4D),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              child: Column(
                children: [
                  Text(
                    weather.cityName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 42,
                      height: 1,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  WeatherIconBox(conditionCode: weather.conditionCode),
                  const SizedBox(height: 12),
                  Text(
                    weather.dateText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weather.temperatureRange,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    weather.conditionText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherIllustrationFallback extends StatelessWidget {
  final String condition;

  const WeatherIllustrationFallback({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    final isRain =
        condition == 'Rain' ||
        condition == 'Drizzle' ||
        condition == 'Thunderstorm';
    final isSnow = condition == 'Snow';

    return CustomPaint(
      painter: _IsometricCityPainter(isRain: isRain, isSnow: isSnow),
      child: const SizedBox.expand(),
    );
  }
}

class WeatherIconBox extends StatelessWidget {
  final String conditionCode;

  const WeatherIconBox({super.key, required this.conditionCode});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: 116,
        height: 116,
        child: Icon(
          _iconForCondition(conditionCode),
          size: 76,
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _iconForCondition(String condition) {
    switch (condition) {
      case 'Clear':
        return Icons.wb_sunny_rounded;
      case 'Rain':
      case 'Drizzle':
      case 'Thunderstorm':
        return Icons.thunderstorm_rounded;
      case 'Snow':
        return Icons.ac_unit_rounded;
      case 'Mist':
      case 'Fog':
      case 'Haze':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy_rounded;
    }
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
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bugünün Detayları',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E3A5F),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: WeatherDetailCard(
                    icon: Icons.water_drop_rounded,
                    title: 'Nem',
                    value: weather.humidity,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: WeatherDetailCard(
                    icon: Icons.air_rounded,
                    title: 'Rüzgar',
                    value: weather.windSpeed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: WeatherDetailCard(
                    icon: Icons.thermostat_rounded,
                    title: 'Hissedilen',
                    value: weather.feelsLike,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: WeatherDetailCard(
                    icon: Icons.compress_rounded,
                    title: 'Basınç',
                    value: weather.pressure,
                  ),
                ),
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF2478A6), size: 26),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7A90),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
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

class ImageCacheInfo extends StatelessWidget {
  final WeatherData weather;

  const ImageCacheInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome_rounded, color: Color(0xFF9A6A00)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Beklenen asset: ${StaticWeatherImageService.expectedAssetName(weather)}',
                style: const TextStyle(
                  color: Color(0xFF365466),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IsometricCityPainter extends CustomPainter {
  final bool isRain;
  final bool isSnow;

  const _IsometricCityPainter({required this.isRain, required this.isSnow});

  @override
  void paint(Canvas canvas, Size size) {
    final sky = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF78C7D2), Color(0xFFF3D9A7), Color(0xFFEAF7F8)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sky);

    final sunPaint = Paint()
      ..color = const Color(0xFFFFD66B).withValues(alpha: 0.72);
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.18),
      size.width * 0.11,
      sunPaint,
    );

    final islandPaint = Paint()..color = const Color(0xFF5BAA8D);
    final island = Path()
      ..moveTo(size.width * 0.13, size.height * 0.64)
      ..lineTo(size.width * 0.52, size.height * 0.45)
      ..lineTo(size.width * 0.9, size.height * 0.64)
      ..lineTo(size.width * 0.52, size.height * 0.82)
      ..close();
    canvas.drawPath(island, islandPaint);

    final roadPaint = Paint()..color = const Color(0xFFDBD0B7);
    final road = Path()
      ..moveTo(size.width * 0.34, size.height * 0.62)
      ..lineTo(size.width * 0.52, size.height * 0.53)
      ..lineTo(size.width * 0.71, size.height * 0.62)
      ..lineTo(size.width * 0.52, size.height * 0.72)
      ..close();
    canvas.drawPath(road, roadPaint);

    _drawBuilding(
      canvas,
      size,
      Offset(size.width * 0.29, size.height * 0.58),
      size.width * 0.12,
      const Color(0xFFEF8B66),
    );
    _drawBuilding(
      canvas,
      size,
      Offset(size.width * 0.45, size.height * 0.52),
      size.width * 0.16,
      const Color(0xFF6FA8DC),
    );
    _drawBuilding(
      canvas,
      size,
      Offset(size.width * 0.62, size.height * 0.58),
      size.width * 0.12,
      const Color(0xFFECCB74),
    );

    final waterPaint = Paint()
      ..color = const Color(0xFF3EA7C0).withValues(alpha: 0.55);
    final water = Path()
      ..moveTo(0, size.height * 0.78)
      ..quadraticBezierTo(
        size.width * 0.24,
        size.height * 0.71,
        size.width * 0.52,
        size.height * 0.82,
      )
      ..quadraticBezierTo(
        size.width * 0.76,
        size.height * 0.91,
        size.width,
        size.height * 0.82,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(water, waterPaint);

    if (isRain || isSnow) {
      final weatherPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.75)
        ..strokeWidth = 2;
      for (var i = 0; i < 18; i++) {
        final x = (i * 37) % size.width;
        final y = size.height * 0.22 + (i % 7) * 34;
        if (isSnow) {
          canvas.drawCircle(Offset(x, y), 3, weatherPaint);
        } else {
          canvas.drawLine(Offset(x, y), Offset(x - 8, y + 18), weatherPaint);
        }
      }
    }
  }

  void _drawBuilding(
    Canvas canvas,
    Size size,
    Offset base,
    double width,
    Color color,
  ) {
    final height = width * 1.55;
    final front = Paint()..color = color;
    final side = Paint()
      ..color = Color.alphaBlend(Colors.black.withValues(alpha: 0.14), color);
    final roof = Paint()
      ..color = Color.alphaBlend(Colors.white.withValues(alpha: 0.2), color);

    final top = Offset(base.dx, base.dy - height);
    final left = Offset(base.dx - width * 0.5, base.dy - width * 0.25);
    final right = Offset(base.dx + width * 0.5, base.dy - width * 0.25);
    final bottom = Offset(base.dx, base.dy);

    final frontPath = Path()
      ..moveTo(left.dx, left.dy)
      ..lineTo(bottom.dx, bottom.dy)
      ..lineTo(right.dx, right.dy)
      ..lineTo(right.dx, top.dy + width * 0.25)
      ..lineTo(top.dx, top.dy + width * 0.5)
      ..lineTo(left.dx, top.dy + width * 0.25)
      ..close();
    canvas.drawPath(frontPath, front);

    final sidePath = Path()
      ..moveTo(right.dx, right.dy)
      ..lineTo(bottom.dx, bottom.dy)
      ..lineTo(bottom.dx, top.dy + width * 0.72)
      ..lineTo(right.dx, top.dy + width * 0.25)
      ..close();
    canvas.drawPath(sidePath, side);

    final roofPath = Path()
      ..moveTo(left.dx, top.dy + width * 0.25)
      ..lineTo(top.dx, top.dy)
      ..lineTo(right.dx, top.dy + width * 0.25)
      ..lineTo(top.dx, top.dy + width * 0.5)
      ..close();
    canvas.drawPath(roofPath, roof);
  }

  @override
  bool shouldRepaint(covariant _IsometricCityPainter oldDelegate) {
    return oldDelegate.isRain != isRain || oldDelegate.isSnow != isSnow;
  }
}
