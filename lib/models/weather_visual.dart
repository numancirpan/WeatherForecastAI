class WeatherVisual {
  final String? assetPath;
  final String? networkUrl;

  const WeatherVisual._({this.assetPath, this.networkUrl});

  const WeatherVisual.fallback() : this._();

  const WeatherVisual.asset(String path) : this._(assetPath: path);

  const WeatherVisual.network(String url) : this._(networkUrl: url);

  bool get hasAsset => assetPath != null && assetPath!.isNotEmpty;

  bool get hasNetwork => networkUrl != null && networkUrl!.isNotEmpty;
}
