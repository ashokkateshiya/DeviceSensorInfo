# 📱 Device Info & Sensor App — Flutter + BLoC + Clean Architecture

A Flutter application that demonstrates:
- Device Information fetching (Battery %, Device Name, OS Version),
- Sensor Data (Gyroscope),
- Flashlight Toggle,
- Native Android/iOS Integration via MethodChannels,
- State Management with BLoC,
- Lottie animations for loading states,
- Unit Testing using bloc_test and mockito,
- Clean architecture (Domain, Data, Presentation layers).

---

## Features

### Dashboard Screen:
- 📱 Displays Device Name, OS Version
- 🔋 Battery Percentage fetched from Native Code
- Auto-loads info on screen open
- Refresh via button

### Sensor Screen:
- 📌 Gyroscope Data (X, Y, Z values) auto-loaded on open
- 🔦 Flashlight toggle using Native Method Channel
- Clean state management with BLoC
- Centered buttons with refresh option

---

## 📂 Project Structure (Clean Architecture)

```
lib/
 ├── core/                  → Constants, Routes, Platform Channels
 ├── data/                  → Data Sources & Repository Implementations
 ├── domain/                → Entities, Repository Interfaces, UseCases
 ├── presentation/          → BLoC, Screens, Widgets
 └── main.dart              → Dependency Injection Setup
```

---

## ✅ How To Run

### 1. Install Flutter:
```bash
flutter doctor
```

### 2. Install Packages:
```bash
flutter pub get
```

### 3. Generate Mocks:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run Project:
```bash
flutter run
```

---

## Unit Testing
```bash
flutter test
```

Includes BLoC unit tests with `bloc_test` and `mockito`.

---

## Platform Channels

- Android: Native code in Kotlin (MainActivity.kt)
- iOS: Native code in Swift (AppDelegate.swift)

---

## Lottie Animations

- Loading animations via [LottieFiles](https://lottiefiles.com/)
- Example animation at `assets/loading.json`

---

## Development Stack

| Layer | Technology |
|-------|------------|
| State Management | BLoC (flutter_bloc) |
| Native Integration | MethodChannel |
| Animations | Lottie |
| Testing | bloc_test, mockito |
| Architecture | Clean Architecture (Domain, Data, Presentation) |

---

