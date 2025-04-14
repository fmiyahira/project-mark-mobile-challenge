# 🌤️ Weather Forecast App

This project is a Flutter-based mobile application designed to provide weather forecasts for multiple cities. The app includes features such as hourly and daily weather updates, caching for offline access, and dynamic UI elements that adapt based on weather conditions.

---

## 📖 Table of Contents
1. [✨ Features](#-features)
2. [🚀 Getting Started](#-getting-started)
3. [▶️ How to Run the Project](#-how-to-run-the-project)
4. [🗂️ Caching Mechanism](#-caching-mechanism)
5. [📋 Business Rules](#-business-rules)
6. [📂 Project Structure](#-project-structure)
7. [🛠️ Technologies Used](#-technologies-used)
8. [🤝 Contributing](#-contributing)

---

## ✨ Features
- **🌡️ Current Weather**: Displays the current temperature, humidity, and pressure for selected cities.
- **⏰ Hourly Forecast**: Provides hourly weather updates for the current day.
- **📅 Daily Forecast**: Displays weather predictions for the upcoming days.
- **🎨 Dynamic UI**: The weather card background and colors change dynamically based on the temperature.
- **📶 Offline Support**: Uses caching to store weather data for offline access.
- **⚠️ Error Handling**: Displays a retry button when an error occurs while fetching data.

---

## 🚀 Getting Started

### Prerequisites
To run this project, you need:
- 🛠️ **Flutter SDK** (version 3.7.2 or higher)
- 🛠️ **Dart SDK**
- 📱 **Android Studio** or **Xcode** (for emulators or physical devices)
- 🔑 **A valid API key** for a weather service (if applicable)

### ⚠️ Important Note
The API key included in this project is **deactivated** by default. To test the application, you must:
1. Activate the provided API key in the weather service dashboard.
2. Alternatively, replace the key with your personal API key in the configuration file.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/fmiyahira/project-mark-mobile-challenge
   cd project-mark-mobile-challenge
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Update the API key:
   - Open the datasource file where the API key is stored (e.g., `/lib/src/features/home/external/datasources/weather_info_datasource_impl.dart`).
   - Replace the placeholder or deactivated key with your personal API key.

4. Run the project:
   ```bash
   flutter run
   ```

---

## ▶️ How to Run the Project

### Running on an Emulator
1. Open **Android Studio** or **Xcode** and start an emulator.
2. Run the following command:
   ```bash
   flutter run
   ```

### Running on a Physical Device
1. Connect your device via USB and enable developer mode.
2. Run the following command:
   ```bash
   flutter run
   ```

### Running Tests
To execute the unit and widget tests:
```bash
flutter test
```

To check test coverage:
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 🗂️ Caching Mechanism

The app uses a caching system to store weather data locally, ensuring offline access and reducing API calls. Here's how it works:

1. **🕒 Local Cache Validation**:
   - The app checks if the last update timestamp is within 10 minutes.
   - If valid, cached data is used.
   - If invalid, new data is fetched from the API.

2. **💾 Data Storage**:
   - Weather data is stored locally using the `shared_preferences` package.
   - The cache includes hourly and daily weather data for all cities.

3. **🔄 Cache Update**:
   - When new data is fetched, it replaces the old cache.
   - The last update timestamp is also updated.

4. **🚨 Fallback**:
   - If the app cannot fetch new data and the cache is invalid, an error message is displayed.

---

## 📋 Business Rules

### 🎨 Weather Card Design
The weather card dynamically changes its background and colors based on the current temperature:
- **❄️ Cold (≤ 5°C)**:
  - Background: Blue gradient
  - Icon: Sun with a frosty effect
- **🌤️ Normal (6°C to 25°C)**:
  - Background: Red gradient
  - Icon: Cloudy or sunny
- **🔥 Hot (> 25°C)**:
  - Background: Orange gradient
  - Icon: Sun with a warm effect

### ⏰ Hourly Weather
- Displays the temperature and weather condition for each hour of the current day.
- Highlights the current hour with a distinct style.

### 📅 Daily Weather
- Shows the minimum and maximum temperatures for the next few days.
- Includes an icon representing the weather condition (e.g., sunny, rainy).

### ⚠️ Error Handling
- If an error occurs while fetching data, a retry button is displayed.
- Clicking the retry button triggers a new API call.

---

## 📂 Project Structure

The project follows a modular structure to ensure scalability and maintainability:

```
lib/
├── core/
│   ├── shared/
│   │   ├── ui/
│   │   │   ├── widgets/       # Reusable UI components
│   │   ├── theme/             # App colors, spacing, and text styles
├── features/
│   ├── home/
│   │   ├── data/              # Data sources and repositories
│   │   ├── domain/            # Business logic and models
│   │   ├── presentation/      # UI components and presenters
├── main.dart                  # Entry point of the app
```

---

## 🛠️ Technologies Used

- **Flutter**: Framework for building cross-platform mobile apps.
- **Dart**: Programming language for Flutter.
- **GetX**: State management and dependency injection.
- **Shared Preferences**: Local storage for caching.

---

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for details.
```