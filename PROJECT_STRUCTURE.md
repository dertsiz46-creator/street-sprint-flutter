# Project Structure

Complete file structure for Street Sprint Flutter game.

```
street-sprint-flutter/
├── README.md                          # Project documentation
├── CHANGELOG.md                       # Version history and features
├── TESTING.md                         # Testing procedures and checklist
├── CONFIGURATION.md                   # Configuration quick reference
├── PROJECT_STRUCTURE.md               # This file
├── pubspec.yaml                       # Flutter dependencies
├── analysis_options.yaml              # Dart linting rules
├── .gitignore                         # Git ignore patterns
│
├── assets/                            # Game assets (gracefully handles missing files)
│   ├── images/                        # Image assets (optional)
│   │   └── .gitkeep
│   └── audio/
│       ├── music/                     # Background music (optional)
│       │   └── .gitkeep
│       └── sfx/                       # Sound effects (optional)
│           └── .gitkeep
│
└── lib/                               # Source code
    ├── main.dart                      # App entry point (167 lines)
    │
    ├── managers/                      # State management
    │   └── game_manager.dart          # Game state & persistence (132 lines)
    │
    ├── utils/                         # Utilities and constants
    │   ├── constants.dart             # Game constants & enums (151 lines)
    │   └── audio_manager.dart         # Audio system (142 lines)
    │
    ├── screens/                       # UI screens
    │   ├── main_menu.dart             # Main menu UI (268 lines)
    │   ├── game_screen.dart           # Game screen with overlay (302 lines)
    │   └── game_over_screen.dart      # Game over UI (314 lines)
    │
    └── game/                          # Flame game implementation
        ├── colorful_city_game.dart    # Main game class (297 lines)
        │
        ├── config/                    # Configuration
        │   └── game_config.dart       # Game settings (97 lines)
        │
        ├── components/                # Game objects
        │   ├── player.dart            # Player character (207 lines)
        │   ├── obstacle.dart          # Obstacle system (120 lines)
        │   ├── coin.dart              # Collectible coins (113 lines)
        │   ├── powerup.dart           # Power-ups (162 lines)
        │   └── road.dart              # Scrolling background (119 lines)
        │
        └── managers/                  # Game logic managers
            ├── score_manager.dart     # Score tracking (62 lines)
            └── spawn_manager.dart     # Object spawning (124 lines)
```

## File Statistics

### Total Files
- **Dart files**: 16
- **Configuration files**: 3 (pubspec.yaml, analysis_options.yaml, .gitignore)
- **Documentation files**: 5 (*.md)
- **Total**: 24 files

### Lines of Code
- **Core Game Logic**: ~1,500 lines
- **UI Screens**: ~900 lines
- **Components**: ~700 lines
- **Managers & Utils**: ~600 lines
- **Total Dart Code**: ~3,700 lines

### File Size Distribution
- **Large files (>200 lines)**: 5 files
  - game_screen.dart (302)
  - game_over_screen.dart (314)
  - colorful_city_game.dart (297)
  - main_menu.dart (268)
  - player.dart (207)

- **Medium files (100-200 lines)**: 7 files
  - obstacle.dart (120)
  - road.dart (119)
  - audio_manager.dart (142)
  - constants.dart (151)
  - game_manager.dart (132)
  - powerup.dart (162)
  - spawn_manager.dart (124)

- **Small files (<100 lines)**: 4 files
  - main.dart (67)
  - game_config.dart (97)
  - coin.dart (113)
  - score_manager.dart (62)

## Directory Purpose

### `/lib`
Main source code directory containing all Dart files.

### `/lib/managers`
Game-wide state management and coordination.
- **game_manager.dart**: Orchestrates game state, persistence, high scores

### `/lib/utils`
Shared utilities, constants, and helper systems.
- **constants.dart**: Enums, colors, game constants
- **audio_manager.dart**: Audio playback and settings

### `/lib/screens`
Flutter UI screens (widgets) for different game states.
- **main_menu.dart**: Entry screen with animations
- **game_screen.dart**: Active gameplay screen
- **game_over_screen.dart**: End game results screen

### `/lib/game`
Flame game engine implementation.

### `/lib/game/config`
Centralized game configuration and tuning.
- **game_config.dart**: All gameplay parameters

### `/lib/game/components`
Individual game objects (Flame components).
- **player.dart**: Player character with controls
- **obstacle.dart**: Objects to avoid
- **coin.dart**: Collectible currency
- **powerup.dart**: Special ability items
- **road.dart**: Animated background

### `/lib/game/managers`
Game-specific logic managers (used by game, not UI).
- **score_manager.dart**: Points and distance tracking
- **spawn_manager.dart**: Object generation and placement

### `/assets`
Game assets (audio, images). All optional - game works without them.

## Key Design Patterns

### State Management
- **Provider**: Used for global game state (GameManager)
- **ChangeNotifier**: Reactive updates to UI
- **Callbacks**: Game events communicated to UI

### Game Architecture
- **Component System**: Modular game objects (Flame pattern)
- **Manager Pattern**: Separate concerns (spawning, scoring, etc.)
- **Configuration**: Centralized settings for easy tuning

### UI Structure
- **Stateless Widgets**: For static displays (main menu, game over)
- **Stateful Widgets**: For dynamic displays (game screen)
- **Composition**: Reusable widgets (_GradientButton, etc.)

## Dependencies Graph

```
main.dart
  └── GameManager (Provider)
      ├── AudioManager
      └── SharedPreferences

MainMenu
  └── GameManager (Consumer)
      └── AudioManager

GameScreen
  ├── GameManager (Consumer)
  └── ColorfulCityGame (Flame)
      ├── SpawnManager
      ├── ScoreManager
      └── Components
          ├── Player
          ├── Road
          ├── Obstacle
          ├── Coin
          └── PowerUp

GameOverScreen
  └── GameManager (Consumer)
```

## Code Organization Principles

1. **Separation of Concerns**: UI, game logic, and state management are separate
2. **Single Responsibility**: Each file has one clear purpose
3. **Dependency Injection**: Managers passed to components that need them
4. **Encapsulation**: Private methods and fields where appropriate
5. **Documentation**: Every file and major function documented

## Build Artifacts (Not in Repo)

```
build/                  # Compiled app (generated)
.dart_tool/            # Dart tooling (generated)
.flutter-plugins       # Flutter plugins cache (generated)
.packages              # Package references (generated)
android/               # Would be generated by Flutter
ios/                   # Would be generated by Flutter
```

## Configuration Files

### `pubspec.yaml`
- Dependencies and versions
- Asset directories
- SDK constraints

### `analysis_options.yaml`
- Linting rules
- Code style preferences

### `.gitignore`
- Excludes build artifacts
- Excludes IDE files
- Excludes generated code

## Next Steps for Development

To extend this project:

1. **Add new component**: Create in `lib/game/components/`
2. **Add new screen**: Create in `lib/screens/`
3. **Add new game mode**: Extend `ColorfulCityGame` or create new game class
4. **Customize appearance**: Modify `lib/utils/constants.dart`
5. **Tune gameplay**: Modify `lib/game/config/game_config.dart`

## Asset Integration

To add actual assets:

1. Place files in appropriate `assets/` subdirectories
2. Reference in code (already set up to handle missing assets)
3. No code changes needed - graceful fallbacks implemented

---

This structure provides a solid foundation for a production Flutter game with clean architecture and room for expansion.
