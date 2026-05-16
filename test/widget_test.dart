import 'package:flutter_test/flutter_test.dart';

import 'package:weather_forecast_ai/main.dart';

void main() {
  testWidgets('shows sample Kocaeli weather when no API key is provided', (
    tester,
  ) async {
    await tester.pumpWidget(const WeatherForecastAIApp());
    await tester.pumpAndSettle();

    expect(find.text('Kocaeli'), findsWidgets);
    expect(find.text('Parçalı Bulutlu'), findsOneWidget);
    expect(find.text('15° - 24°'), findsOneWidget);
  });
}
