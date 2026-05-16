# Run WeatherForecastAI with a Weather API Key

The app is prepared to use OpenWeather API.

## 1. Run Without API Key

If you run the app normally, it uses sample Kocaeli data:

```bash
flutter run
```

## 2. Run With API Key

After getting an OpenWeather API key, run the app like this:

```bash
flutter run --dart-define=WEATHER_API_KEY=YOUR_API_KEY_HERE
```

Example:

```bash
flutter run --dart-define=WEATHER_API_KEY=abc123
```

## 3. Why We Use `--dart-define`

The API key should not be written directly into the source code.

This method keeps the key outside GitHub and passes it to the app while running.

## 4. Current Behavior

- If `WEATHER_API_KEY` is empty, the app shows sample Kocaeli data.
- If `WEATHER_API_KEY` exists, the app requests real weather data from OpenWeather.

## 5. Chrome Run Example

When Flutter asks for a device, select Chrome:

```text
[1]: Windows
[2]: Chrome
[3]: Edge
```

Then enter:

```text
2
```

