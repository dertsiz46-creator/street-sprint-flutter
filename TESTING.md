# Testing Guide for Street Sprint

## Quick Start Test
Once Flutter is installed, run these commands to verify the game works:

```bash
# Install dependencies
flutter pub get

# Analyze code for issues
flutter analyze

# Run the game in debug mode
flutter run

# Build release APK
flutter build apk --release
```

## Expected Results

### 1. Main Menu Screen
- ✅ Should display "STREET SPRINT" title with animations
- ✅ High score displays (initially 0)
- ✅ Total coins displays (initially 0)
- ✅ PLAY button with gradient
- ✅ Music and sound toggle buttons
- ✅ All UI elements should animate on load

### 2. Game Screen
- ✅ Game starts immediately after pressing PLAY
- ✅ Player character appears in center lane at bottom
- ✅ Road scrolls from top to bottom
- ✅ Score displays in top-left
- ✅ Coin counter displays in top-center
- ✅ Pause button in top-right

### 3. Gameplay Controls
Test all swipe gestures:
- ✅ Swipe LEFT: Player moves to left lane
- ✅ Swipe RIGHT: Player moves to right lane
- ✅ Swipe UP: Player jumps
- ✅ Swipe DOWN: Player slides
- ✅ Lane switching is smooth and responsive
- ✅ Can't move beyond left/right boundaries

### 4. Game Objects Spawning
- ✅ Obstacles spawn regularly (cars, barriers, cones)
- ✅ Coins spawn in vertical clusters
- ✅ Power-ups spawn occasionally (magnet, shield, jetpack, 2x score)
- ✅ All objects scroll down the screen
- ✅ Objects despawn when off-screen

### 5. Collision Detection
- ✅ Hitting obstacle without shield → Game Over
- ✅ Jumping over low obstacles → No collision
- ✅ Sliding under obstacles → No collision (except barriers)
- ✅ Collecting coins → Score increases, coin count increases
- ✅ Collecting power-ups → Power-up activates

### 6. Power-ups
Test each power-up:
- ✅ MAGNET: Nearby coins are attracted to player
- ✅ SHIELD: Player has visible shield, can hit one obstacle safely
- ✅ JETPACK: Visual effect active
- ✅ 2X SCORE: Score increases at double rate
- ✅ Power-up timer displays at top of screen
- ✅ Power-ups expire after duration

### 7. Difficulty Progression
- ✅ Game speed increases over time
- ✅ Speed caps at maximum value
- ✅ Game remains playable at max speed

### 8. Pause Menu
- ✅ Pause button works
- ✅ Game stops when paused
- ✅ Pause dialog shows current score and coins
- ✅ RESUME button continues game
- ✅ QUIT button returns to main menu

### 9. Game Over Screen
- ✅ Game over screen appears after collision
- ✅ Final score displays correctly
- ✅ Coins collected displays correctly
- ✅ High score updates if beaten
- ✅ "NEW HIGH SCORE!" banner shows when applicable
- ✅ RETRY button starts new game
- ✅ MENU button returns to main menu

### 10. Persistence
- ✅ High score saves between sessions
- ✅ Total coins accumulate across games
- ✅ Audio settings persist

### 11. Audio System
- ✅ Game works without audio files (no crashes)
- ✅ Audio toggle buttons work on main menu
- ✅ Background music plays when enabled
- ✅ Sound effects play for actions when enabled

## Performance Tests

### Frame Rate
- Target: 60 FPS on mid-range devices
- Test on both debug and release builds
- Monitor frame drops during intensive gameplay

### Memory Usage
- Game should not leak memory during extended play
- Test multiple game sessions in a row
- Check memory usage after 10+ games

### Battery Consumption
- Monitor battery drain on release build
- Should be reasonable for mobile game

## UI/UX Tests

### Visual Quality
- ✅ Gradients render smoothly
- ✅ Colors are vibrant and appealing
- ✅ Animations are smooth
- ✅ Text is readable
- ✅ UI scales properly on different screen sizes

### Responsiveness
- ✅ All buttons respond immediately to taps
- ✅ Swipe gestures feel natural
- ✅ No input lag

## Edge Cases

### Rapid Input
- Multiple quick swipes in succession
- Should queue or handle gracefully

### Long Play Session
- Play for 10+ minutes
- Check for memory leaks or performance degradation

### Background/Foreground
- Send app to background during gameplay
- Return to app - game should pause

### Screen Rotation
- App locked to portrait (verify)
- Should not rotate to landscape

## Known Limitations

1. **Audio Assets**: Game designed to work without audio files
2. **Image Assets**: Uses programmatic drawing, no images needed
3. **Platform**: Optimized for Android mobile devices
4. **Orientation**: Portrait mode only

## Troubleshooting Common Issues

### "flutter: command not found"
- Install Flutter SDK: https://flutter.dev/docs/get-started/install

### Dependency version conflicts
```bash
flutter clean
flutter pub get
```

### Build fails
```bash
flutter doctor
# Fix any issues reported
flutter clean
flutter pub get
```

### Game runs slowly
- Test in release mode: `flutter run --release`
- Check device specifications

## Success Criteria

The game is considered complete and functional when:
- ✅ All 11 test categories pass
- ✅ No crashes during normal gameplay
- ✅ Performance is acceptable (>30 FPS)
- ✅ High scores and coins persist correctly
- ✅ Game loop works: Menu → Play → Game Over → Menu

## Reporting Issues

If you find bugs or issues:
1. Note the exact steps to reproduce
2. Check device specifications
3. Verify Flutter and Dart versions
4. Include error messages from console
5. Open an issue on GitHub with details
