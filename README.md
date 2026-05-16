# WeatherForecastAI

WeatherForecastAI is a mobile weather application project planned for both Android and iOS. The main idea is to combine real-time weather data with AI-generated city-specific visual backgrounds.

## Project Goal

The application will show weather information in a modern mobile interface and use AI-generated 9:16 isometric city illustrations as premium weather backgrounds.

Instead of storing hundreds of city images inside the mobile app, the long-term plan is to generate images with AI, save them in cloud storage, and reuse them with a cache strategy.

## Planned Technology Stack

### Mobile App

- Flutter
- Dart
- Android and iOS support from a single codebase

### Weather Data

- OpenWeather API or another weather API provider

### AI Image System

- Dynamic prompt generation
- AI image generation service
- Image cache by city + weather condition + time period

### Backend / Storage, Later Stage

- ASP.NET Core Web API or Firebase Cloud Functions
- Firebase Storage, Cloudinary, or Supabase Storage
- Database for generated image URLs

## Development Phases

### Phase 1: Mobile UI Prototype

- Create Flutter project structure
- Build a static home screen
- Show sample city weather data
- Use a placeholder weather illustration
- Prepare reusable widgets

### Phase 2: Weather API Integration

- Connect to weather API
- Search weather by city name
- Display current temperature, min/max temperature, condition, humidity, and wind speed

### Phase 3: AI Image Prompt System

- Generate prompt dynamically by city and weather condition
- Keep AI-generated image free from text
- Overlay real weather data inside Flutter UI

### Phase 4: AI Image Cache Backend

- Check if generated image already exists
- Generate only if missing
- Save image URL to database
- Reuse image for the same city + condition

### Phase 5: Final App Improvements

- City search
- Favorite cities
- 5-day forecast
- UI animations
- Android APK build
- iOS preparation

## Important Design Decision

AI images should not contain city name, date, temperature, or weather text. Text rendering should be handled by Flutter to avoid incorrect AI-generated typography.

Recommended image prompt rule:

> Do not include any text, numbers, labels, logos, or UI typography in the image. Leave clean empty space at the top for app UI overlay.

## First Milestone

The first working version will be a simple Flutter screen with static sample data:

- City: Kocaeli
- Date: 16 Mayıs 2026, Cumartesi
- Condition: Parçalı Bulutlu
- Temperature range: 15° - 24°
- Humidity: 62%
- Wind: 12 km/h

