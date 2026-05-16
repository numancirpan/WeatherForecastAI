import '../models/favorite_city.dart';

class FavoriteCityService {
  final List<FavoriteCity> _favorites = const [
    FavoriteCity(name: 'Kocaeli', countryCode: 'TR'),
    FavoriteCity(name: 'İstanbul', countryCode: 'TR'),
    FavoriteCity(name: 'Ankara', countryCode: 'TR'),
    FavoriteCity(name: 'İzmir', countryCode: 'TR'),
  ];

  List<FavoriteCity> getFavorites() {
    return List.unmodifiable(_favorites);
  }
}
