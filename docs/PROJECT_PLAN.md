# WeatherForecastAI Project Plan

## 1. MVP Scope

The first version should stay simple. The goal is to make a working mobile weather screen before adding advanced AI features.

MVP features:

- Static weather home screen
- City name
- Weather condition
- Temperature range
- Humidity and wind cards
- AI-style hero image placeholder
- Clean mobile layout

Not included in MVP:

- Login system
- Database
- Real-time AI image generation
- Payment system
- Complex backend

## 2. App Screens

### Home Screen

Shows the selected city's weather information.

Main UI elements:

- Hero weather background
- City name
- Date
- Weather condition
- Temperature range
- Weather detail cards

### Search Screen, Later

Allows the user to search for a city.

### Favorites Screen, Later

Shows saved favorite cities.

### Details Screen, Later

Shows detailed weather data such as humidity, wind, pressure, sunrise, sunset, and forecast.

## 3. Suggested Folder Structure

```text
lib/
  main.dart
  models/
    weather_model.dart
  screens/
    home_screen.dart
  services/
    weather_service.dart
  utils/
    image_mapper.dart
  widgets/
    weather_detail_card.dart
    weather_header.dart
assets/
  images/
    placeholder_weather.png
```

## 4. AI Image Strategy

The app should not store every city image locally.

Recommended flow:

```text
User selects city
Weather data is fetched
App/backend creates image key
Backend checks cache
If image exists, return URL
If image does not exist, generate with AI
Save image to cloud storage
Return image URL to mobile app
```

Example image key:

```text
kocaeli_clouds_day_spring
istanbul_rain_night_winter
ankara_clear_day_summer
```

## 5. Prompt Strategy

AI images should be generated as background illustrations only. The UI text should be rendered by Flutter.

This avoids problems such as:

- Wrong city names
- Broken Turkish characters
- Incorrect dates
- Wrong temperature values

## 6. Recommended Prompt Template

```text
Create a vertical 9:16 mobile weather app hero background illustration for {CITY_NAME}.

Use a clear 45-degree top-down isometric miniature 3D cartoon style. Show iconic and recognizable landmarks of {CITY_NAME}. Integrate the weather condition creatively into the atmosphere and architecture.

Weather condition: {WEATHER_CONDITION}
Time period: {DAY_OR_NIGHT}
Season: {SEASON}

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
```

## 7. Development Order

1. Create Flutter project locally
2. Add repository files to GitHub
3. Build static home screen
4. Add sample weather data model
5. Add OpenWeather API integration
6. Add city search
7. Add AI image prompt generator
8. Add backend image cache
9. Improve UI/UX
10. Build Android APK

