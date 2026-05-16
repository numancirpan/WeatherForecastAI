# WeatherForecastAI

WeatherForecastAI is a Flutter mobile weather application project for Android and iOS. The main idea is to combine real-time weather data with reusable AI-generated city weather illustrations.

## Project Goal

The app shows current weather information in a modern mobile interface. For city visuals, the preferred production flow is:

1. User selects a city.
2. Weather data is fetched from OpenWeather.
3. The app asks the image backend whether a city + condition + time period image already exists.
4. If it exists, the stored image URL is returned.
5. If it does not exist, the backend generates the image with AI, saves it to storage, and returns the URL.
6. Future users reuse the same image instead of generating it again.

## Current App Features

- Flutter single-codebase app structure
- OpenWeather city search integration
- Sample Kocaeli weather fallback when no API key is provided
- Free first-version image flow with local static PNG assets
- AI image backend hook through `IMAGE_API_BASE_URL`
- Built-in fallback hero illustration when the backend image is unavailable
- Weather details: humidity, wind, feels-like temperature, and pressure

## Planned Technology Stack

### Mobile App

- Flutter
- Dart
- Android and iOS support from a single codebase

### Weather Data

- OpenWeather API

### AI Image System

- Dynamic prompt generation
- Image cache by city + weather condition + time period
- Backend-side AI image generation
- Storage URL reuse after the first generation

### Backend / Storage

- ASP.NET Core Web API or Firebase Cloud Functions
- Firebase Storage, Cloudinary, or Supabase Storage
- Database table or document collection for generated image URLs

## Expected Image Backend Contract

The first version does not require this backend. The app first checks local files under `assets/images/`, for example:

```text
assets/images/kocaeli_clouds.png
```

See `docs/STATIC_IMAGE_ASSETS.md` for the full free asset naming plan.

When a future backend is added, this is the expected contract.

Mobile request:

```text
GET /weather-images?city=Kocaeli&condition=Clouds&period=day&minTemp=15&maxTemp=24
```

Expected JSON response:

```json
{
  "imageUrl": "https://storage.example.com/weather/kocaeli-clouds-day.png",
  "cacheKey": "kocaeli-clouds-day",
  "prompt": "Create a vertical 9:16 mobile weather app hero illustration...",
  "generatedNow": false
}
```

## Important Design Decision

AI images should not contain city name, date, temperature, or weather text. Text rendering is handled by Flutter to avoid incorrect AI-generated typography.

Recommended image prompt rule:

> Do not include any text, numbers, labels, logos, or UI typography in the image. Leave clean empty space at the top for app UI overlay.

## First Milestone Sample Data

- City: Kocaeli
- Date: 16 Mayıs 2026, Cumartesi
- Condition: Parçalı Bulutlu
- Temperature range: 15° - 24°
- Humidity: 62%
- Wind: 12 km/h
