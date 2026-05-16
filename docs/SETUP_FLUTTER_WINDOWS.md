# Flutter Setup on Windows

This guide explains how to start the WeatherForecastAI mobile app locally on Windows.

## 1. Install Required Tools

Install these tools first:

- Flutter SDK
- Android Studio
- Visual Studio Code
- Flutter extension for VS Code
- Dart extension for VS Code

## 2. Check Flutter Installation

Open PowerShell or Command Prompt and run:

```bash
flutter doctor
```

Flutter will show missing requirements. Complete the missing steps shown in the output.

## 3. Create the Flutter Project

Clone this repository first:

```bash
git clone https://github.com/numancirpan/WeatherForecastAI.git
cd WeatherForecastAI
```

Then create Flutter platform files in the current folder:

```bash
flutter create .
```

This command creates the required Android, iOS, Windows, and Flutter project files.

## 4. Run the App

Start an Android emulator or connect your Android phone with USB debugging enabled.

Then run:

```bash
flutter run
```

## 5. Useful Commands

Check connected devices:

```bash
flutter devices
```

Clean project:

```bash
flutter clean
```

Get packages:

```bash
flutter pub get
```

Run again:

```bash
flutter run
```

## 6. Important Note About iOS

You can write Flutter code on Windows, but building and publishing the iOS version usually requires macOS and Xcode.

For now, develop and test on Android. The same Flutter code can later be prepared for iOS on a Mac.

