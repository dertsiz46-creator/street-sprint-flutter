# Configuration Quick Reference

This guide provides quick access to key game configuration values that can be adjusted to fine-tune gameplay.

## Game Speed Settings
*Location: `lib/game/config/game_config.dart`*

```dart
initialSpeed = 300.0        // Starting game speed (units/second)
maxSpeed = 800.0            // Maximum game speed
speedIncrement = 10.0       // Speed increase per interval
speedIncrementInterval = 5.0 // Seconds between speed increases
```

**Adjustment Tips:**
- Lower `initialSpeed` for easier gameplay
- Reduce `speedIncrement` for gentler difficulty curve
- Increase `speedIncrementInterval` to slow progression

## Spawn Rates
*Location: `lib/game/config/game_config.dart`*

```dart
obstacleSpawnInterval = 1.5   // Seconds between obstacles
coinSpawnInterval = 0.5       // Seconds between coin clusters
powerUpSpawnInterval = 10.0   // Seconds between power-ups
```

**Adjustment Tips:**
- Increase spawn intervals for easier gameplay
- Decrease for more challenging experience
- Keep obstacles >= 1.0s for playability

## Player Settings
*Location: `lib/game/config/game_config.dart`*

```dart
playerWidth = 60.0          // Player character width
playerHeight = 80.0         // Player character height
jumpHeight = 150.0          // How high player jumps
jumpDuration = 0.5          // Jump animation duration (seconds)
slideDuration = 0.5         // Slide animation duration (seconds)
```

**Adjustment Tips:**
- Increase `jumpHeight` to jump over more obstacles
- Adjust durations for faster/slower animations

## Power-up Durations
*Location: `lib/utils/constants.dart`*

```dart
magnetDuration = 5.0        // Magnet effect duration (seconds)
shieldDuration = 8.0        // Shield protection duration (seconds)
jetpackDuration = 3.0       // Jetpack effect duration (seconds)
doubleScoreDuration = 10.0  // 2x score duration (seconds)
```

**Adjustment Tips:**
- Increase durations to make power-ups more powerful
- Decrease to increase challenge

## Scoring Values
*Location: `lib/utils/constants.dart`*

```dart
coinValue = 10              // Points per coin collected
distanceMultiplier = 1      // Points per distance interval
```

**Adjustment Tips:**
- Increase `coinValue` to reward collection more
- Adjust `distanceMultiplier` for distance-based scoring

## Collision Detection
*Location: `lib/game/config/game_config.dart`*

```dart
collisionTolerance = 0.7    // 70% of object size for collision
```

**Adjustment Tips:**
- Lower value = more forgiving collisions (easier)
- Higher value = stricter collisions (harder)
- Range: 0.5 (very forgiving) to 1.0 (exact)

## UI Colors & Gradients
*Location: `lib/utils/constants.dart`*

```dart
// Primary colors
primaryColor = Color(0xFF6C63FF)      // Purple
secondaryColor = Color(0xFFFF6B9D)    // Pink
accentColor = Color(0xFFFFC107)       // Gold
backgroundColor = Color(0xFF1A1A2E)   // Dark blue
```

**Customization:**
- Change hex values to match desired theme
- Update gradients for different visual style
- Maintain contrast for readability

## Audio Settings
*Location: `lib/utils/constants.dart`*

```dart
defaultMusicVolume = 0.5    // 50% volume for music
defaultSfxVolume = 0.7      // 70% volume for sound effects
```

**Adjustment Tips:**
- Values range from 0.0 (silent) to 1.0 (full volume)
- Music typically lower than SFX

## Coin Clusters
*Location: `lib/game/config/game_config.dart`*

```dart
coinClusterSize = 5         // Number of coins per cluster
coinSpacing = 50.0          // Distance between coins in cluster
```

**Adjustment Tips:**
- Increase `coinClusterSize` for more rewards
- Adjust `coinSpacing` for easier/harder collection

## Obstacle Settings
*Location: `lib/game/config/game_config.dart`*

```dart
obstacleWidth = 70.0        // Obstacle width
obstacleHeight = 80.0       // Obstacle height
obstacleMinGap = 200.0      // Minimum distance between obstacles
```

**Adjustment Tips:**
- Increase `obstacleMinGap` for easier gameplay
- Adjust dimensions to change visual appearance

## Game Dimensions
*Location: `lib/utils/constants.dart`*

```dart
gameWidth = 400.0           // Game world width
gameHeight = 800.0          // Game world height
laneWidth = 100.0           // Width of each lane
```

**Note:** Changing these may require adjusting other values proportionally.

## Quick Difficulty Presets

### Easy Mode
```dart
initialSpeed = 250.0
speedIncrement = 5.0
obstacleSpawnInterval = 2.0
collisionTolerance = 0.6
magnetDuration = 8.0
shieldDuration = 12.0
```

### Normal Mode (Default)
```dart
initialSpeed = 300.0
speedIncrement = 10.0
obstacleSpawnInterval = 1.5
collisionTolerance = 0.7
magnetDuration = 5.0
shieldDuration = 8.0
```

### Hard Mode
```dart
initialSpeed = 350.0
speedIncrement = 15.0
obstacleSpawnInterval = 1.0
collisionTolerance = 0.8
magnetDuration = 3.0
shieldDuration = 5.0
```

## Testing Changes

After modifying configuration values:

1. **Hot Reload** (during development):
   ```bash
   # Press 'r' in terminal or use IDE hot reload
   ```

2. **Full Restart** (for major changes):
   ```bash
   flutter run
   ```

3. **Test Thoroughly**:
   - Play multiple rounds
   - Test all game states
   - Verify power-ups still work
   - Check collision detection
   - Ensure difficulty curve feels right

## Common Customization Scenarios

### Make Game More Forgiving
- ↑ `collisionTolerance` to 0.6
- ↑ `obstacleSpawnInterval` to 2.0
- ↑ Power-up durations by 50%
- ↓ `speedIncrement` to 5.0

### Make Game More Challenging
- ↑ `collisionTolerance` to 0.9
- ↓ `obstacleSpawnInterval` to 1.0
- ↓ Power-up durations by 30%
- ↑ `speedIncrement` to 20.0

### Increase Coin Rewards
- ↑ `coinValue` to 20
- ↑ `coinClusterSize` to 8
- ↓ `coinSpacing` to 40.0
- ↓ `coinSpawnInterval` to 0.3

### Make Power-ups More Impactful
- ↑ All power-up durations by 100%
- ↓ `powerUpSpawnInterval` to 7.0
- ↑ `magnetRadius` to 200.0

## Notes

- Always maintain game balance when adjusting values
- Test changes on target device (mobile performance varies)
- Some values are interdependent (e.g., speed and spawn rates)
- Keep player experience in mind - too easy or too hard reduces engagement
- Document any custom presets you create

## Backup Reminder

Before making significant changes, consider:
1. Creating a git branch
2. Noting original values
3. Testing incrementally
4. Reverting if gameplay suffers

---

For more details, see the full source files in:
- `lib/game/config/game_config.dart`
- `lib/utils/constants.dart`
