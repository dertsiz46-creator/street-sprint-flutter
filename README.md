# Street Sprint 🏃‍♂️

A colorful 3D-style endless runner mobile game built with Flutter and Flame game engine, inspired by Subway Surfers.

## 🎮 Game Features

### Core Gameplay
- **Endless Runner Mechanics**: Run through an infinite colorful city street
- **3-Lane System**: Swipe left/right to switch lanes, up to jump, down to slide
- **Progressive Difficulty**: Game speed increases over time for added challenge
- **Smooth Controls**: Intuitive swipe gesture controls optimized for mobile

### Game Elements
- **Obstacles**: Dodge cars, barriers, and traffic cones
- **Collectible Coins**: Earn points and currency
- **Power-ups**:
  - 🧲 **Magnet**: Automatically attracts nearby coins
  - 🛡️ **Shield**: Protects from one collision
  - 🚀 **Jetpack**: Visual effect and bonus
  - 2️⃣ **Double Score**: 2x score multiplier

### Features
- ✅ Score system with distance tracking
- ✅ Persistent high scores using SharedPreferences
- ✅ Coin currency system
- ✅ Pause/Resume functionality
- ✅ Beautiful gradient UI with animations
- ✅ Sound effects and music support (gracefully handles missing assets)
- ✅ Game state management with Provider

## 🎨 Visual Design

The game features a vibrant, colorful aesthetic with:
- Gradient backgrounds and UI elements
- Smooth animations using flutter_animate
- Colorful 3D-style game objects
- Dynamic visual feedback for power-ups and collisions

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point
├── managers/
│   └── game_manager.dart              # Game state management
├── utils/
│   ├── constants.dart                 # Game constants & enums
│   └── audio_manager.dart             # Audio system
├── screens/
│   ├── main_menu.dart                 # Main menu UI
│   ├── game_screen.dart               # Game screen with overlay
│   └── game_over_screen.dart          # Game over UI
└── game/
    ├── colorful_city_game.dart        # Main Flame game class
    ├── config/
    │   └── game_config.dart           # Game configuration
    ├── components/
    │   ├── player.dart                # Player character
    │   ├── obstacle.dart              # Obstacle system
    │   ├── coin.dart                  # Collectible coins
    │   ├── powerup.dart               # Power-up items
    │   └── road.dart                  # Scrolling background
    └── managers/
        ├── spawn_manager.dart         # Object spawning logic
        └── score_manager.dart         # Score tracking
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions
- Android device or emulator (for testing)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/dertsiz46-creator/street-sprint-flutter.git
   cd street-sprint-flutter
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the game**:
   ```bash
   flutter run
   ```

   Or for release mode:
   ```bash
   flutter run --release
   ```

### Building for Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Google Play)
flutter build appbundle --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## 🎯 How to Play

1. **Start**: Tap the PLAY button on the main menu
2. **Controls**:
   - Swipe LEFT: Move to left lane
   - Swipe RIGHT: Move to right lane
   - Swipe UP: Jump over obstacles
   - Swipe DOWN: Slide under obstacles
3. **Objectives**:
   - Avoid obstacles (cars, barriers, cones)
   - Collect coins for points
   - Grab power-ups for special abilities
   - Survive as long as possible to beat your high score!

## 🔧 Configuration

### Game Settings
Edit `lib/game/config/game_config.dart` to adjust:
- Player speed and jump height
- Spawn rates for obstacles, coins, and power-ups
- Power-up durations
- Difficulty progression

### Visual Customization
Edit `lib/utils/constants.dart` to customize:
- Color scheme and gradients
- UI styling
- Game dimensions

## 📦 Dependencies

- **flame**: ^1.16.0 - Game engine
- **flame_audio**: ^2.1.0 - Audio support for Flame
- **provider**: ^6.1.1 - State management
- **shared_preferences**: ^2.2.2 - Data persistence
- **audioplayers**: ^5.2.1 - Audio playback
- **flutter_animate**: ^4.5.0 - UI animations
- **google_mobile_ads**: ^5.0.0 - Ad integration (optional)
- **in_app_purchase**: ^3.1.13 - In-app purchases (optional)

## 🎵 Audio Assets

The game is designed to work with or without audio assets. If audio files are missing, the game will continue to function normally.

To add audio files, place them in:
- `assets/audio/music/` - Background music
- `assets/audio/sfx/` - Sound effects

Expected sound effects:
- `game_start.mp3`
- `game_over.mp3`
- `coin_collect.mp3`
- `jump.mp3`
- `slide.mp3`
- `powerup_collect.mp3`

## 🖼️ Image Assets

Place any custom images in `assets/images/` directory. The game currently uses programmatically drawn shapes for all game objects, so no images are required.

## 🎮 Game Mechanics Details

### Scoring System
- Distance traveled: 1 point per interval
- Coins collected: 10 points each
- Double Score power-up: 2x multiplier for limited time

### Collision Detection
- Forgiving collision boxes (70% of object size)
- Jump over obstacles when airborne
- Slide under certain obstacles
- Shield power-up grants invincibility

### Difficulty Progression
- Speed increases every 5 seconds
- Maximum speed cap to keep game playable
- Spawn rates remain consistent for balanced gameplay

## 🐛 Troubleshooting

### Game won't start
- Ensure Flutter is properly installed: `flutter doctor`
- Clean the project: `flutter clean && flutter pub get`
- Check for dependency conflicts

### Performance issues
- Run in release mode: `flutter run --release`
- Close other apps to free up memory
- Check device specifications

### Audio not working
- Audio is optional - game will work without it
- Check that audio files are in correct directories
- Verify file names match code references

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## 📄 License

This project is available for educational and personal use.

## 🎯 Future Enhancements

Potential features for future versions:
- [ ] Character customization
- [ ] Multiple game modes
- [ ] Daily challenges
- [ ] Leaderboards
- [ ] More power-up types
- [ ] Different environments/themes
- [ ] Achievement system
- [ ] Shop for upgrades using collected coins

## 👨‍💻 Development

Built with ❤️ using Flutter and Flame

For questions or support, please open an issue on GitHub.

---

**Enjoy playing Street Sprint! 🏃‍♂️💨**