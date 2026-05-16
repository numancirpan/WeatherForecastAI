class WeatherImage {
  final String imageUrl;
  final String cacheKey;
  final String prompt;
  final bool generatedNow;

  const WeatherImage({
    required this.imageUrl,
    required this.cacheKey,
    required this.prompt,
    required this.generatedNow,
  });

  factory WeatherImage.fromJson(Map<String, dynamic> json) {
    return WeatherImage(
      imageUrl: json['imageUrl'] as String? ?? '',
      cacheKey: json['cacheKey'] as String? ?? '',
      prompt: json['prompt'] as String? ?? '',
      generatedNow: json['generatedNow'] as bool? ?? false,
    );
  }
}
