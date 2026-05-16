class AiPromptBuilder {
  String buildCityWeatherPrompt({
    required String cityName,
    required String weatherCondition,
    required String timePeriod,
    required String season,
  }) {
    return '''
Create a vertical 9:16 mobile weather app hero background illustration for $cityName.

Use a clear 45-degree top-down isometric miniature 3D cartoon style. Show iconic and recognizable landmarks of $cityName. Integrate the weather condition creatively into the atmosphere and architecture.

Weather condition: $weatherCondition
Time period: $timePeriod
Season: $season

Visual requirements:
- Premium mobile weather app background
- No text
- No numbers
- No logos
- No watermark
- Leave clean empty space at the top for UI overlay
- City landmarks should be in the lower and middle parts of the image
- Soft refined textures
- Realistic PBR-like materials
- Gentle realistic lighting
- Soft shadows
- Fresh, calming, minimalist aesthetic
- Smooth flat-color sky background
- Vertical 9:16 composition
''';
  }
}
