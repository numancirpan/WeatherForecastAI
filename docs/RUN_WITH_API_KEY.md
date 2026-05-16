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

## 3. Run With Weather and Image Backend

If you also have a backend that checks/generated cached AI city images, pass its base URL:

```bash
flutter run --dart-define=WEATHER_API_KEY=YOUR_API_KEY_HERE --dart-define=IMAGE_API_BASE_URL=https://your-backend.example.com
```

The app calls:

```text
GET {IMAGE_API_BASE_URL}/weather-images
```

with city, weather condition, local date, and temperature query parameters. If the backend is not configured or does not return a valid image, the app shows its built-in fallback illustration.

## 4. Why We Use `--dart-define`

The API key should not be written directly into the source code.

This method keeps the key outside GitHub and passes it to the app while running.

## 5. Current Behavior

- If `WEATHER_API_KEY` is empty, the app shows sample Kocaeli data.
- If `WEATHER_API_KEY` exists, the app requests real weather data from OpenWeather.
- If `IMAGE_API_BASE_URL` is empty, the app uses its built-in weather illustration.
- If `IMAGE_API_BASE_URL` exists, the app asks the backend for a cached/generated AI image URL.

## 6. Chrome Run Example

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

