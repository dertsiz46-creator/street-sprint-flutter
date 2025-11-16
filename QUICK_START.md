# Quick Start Guide

Get Street Sprint running in 3 simple steps!

## Prerequisites

✅ Flutter SDK installed (>=3.0.0)  
✅ Android Studio / VS Code with Flutter plugin  
✅ Android device or emulator  

Check your setup:
```bash
flutter doctor
```

## Installation

### Step 1: Get Dependencies
```bash
cd street-sprint-flutter
flutter pub get
```
This downloads all required packages (~30 seconds).

### Step 2: Run the Game
```bash
flutter run
```
Or press F5 in VS Code / Android Studio.

The game will launch on your connected device/emulator!

### Step 3: Play!
- Tap **PLAY** button
- Swipe to control the character
- Collect coins and avoid obstacles
- Beat your high score!

## Controls

| Gesture | Action |
|---------|--------|
| Swipe ← | Move left |
| Swipe → | Move right |
| Swipe ↑ | Jump |
| Swipe ↓ | Slide |
| Tap ⏸️ | Pause |

## First Time Setup

The game creates these on first run:
- High score storage (SharedPreferences)
- Audio settings
- Coin bank

All data persists between sessions!

## Building Release APK

For production build:
```bash
flutter build apk --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`

Install on device:
```bash
flutter install
```

## Troubleshooting

### "flutter: command not found"
Install Flutter: https://flutter.dev/docs/get-started/install

### Dependencies fail to install
```bash
flutter clean
rm -rf pubspec.lock
flutter pub get
```

### Build errors
```bash
flutter doctor
# Fix any reported issues
flutter clean
flutter pub get
flutter run
```

### Game runs slowly
Use release mode:
```bash
flutter run --release
```

## What You Get

✅ **Complete endless runner game**
- Main menu with animations
- Gameplay with 3-lane system
- Pause menu
- Game over screen

✅ **Features**
- Progressive difficulty
- 4 types of power-ups
- Coin collection
- High score tracking
- Persistent data

✅ **Polish**
- Beautiful gradient UI
- Smooth animations
- Sound system (works without assets)
- Mobile-optimized controls

## File Structure (Important Files)

```
lib/
├── main.dart                    # Start here
├── screens/
│   ├── main_menu.dart          # First screen you see
│   ├── game_screen.dart        # Main gameplay
│   └── game_over_screen.dart   # Results screen
└── game/
    ├── colorful_city_game.dart # Game engine
    └── components/             # Game objects
```

## Customization

Want to tweak the game? See:
- **CONFIGURATION.md** - All tunable parameters
- **PROJECT_STRUCTURE.md** - Code organization
- **lib/utils/constants.dart** - Colors and values
- **lib/game/config/game_config.dart** - Gameplay settings

## Next Steps

1. **Play the game** - Try it out!
2. **Read README.md** - Full feature list
3. **Check TESTING.md** - Testing procedures
4. **See CHANGELOG.md** - What's included

## Demo Checklist

Try these to see all features:

- [ ] Launch game and view main menu
- [ ] Toggle music/sound buttons
- [ ] Tap PLAY to start game
- [ ] Swipe left/right to switch lanes
- [ ] Swipe up to jump
- [ ] Swipe down to slide
- [ ] Collect coins (golden circles)
- [ ] Grab a power-up (colored circles)
- [ ] Hit an obstacle (game over)
- [ ] View game over screen
- [ ] Tap RETRY to play again
- [ ] Beat your high score
- [ ] Pause during gameplay
- [ ] Return to menu

## Support

- **Issues**: Open issue on GitHub
- **Questions**: Check README.md and documentation
- **Modifications**: See CONFIGURATION.md

## Performance Tips

For best experience:
- Use release mode for testing
- Run on physical device for accurate performance
- Close other apps to free memory
- Update to latest Flutter stable

## Development Mode

During development:
```bash
# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
# Quit: Press 'q' in terminal
```

## Success! 🎉

If you can:
- See the main menu
- Start a game
- Control the character
- Hit obstacles and see game over

**The game is working perfectly!**

---

**Need Help?** Check the other documentation files or open an issue.

**Ready to Customize?** See CONFIGURATION.md for all settings.

**Want to Contribute?** Fork the repo and submit a PR!

Enjoy playing Street Sprint! 🏃‍♂️💨
