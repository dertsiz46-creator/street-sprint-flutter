import 'package:flutter/material.dart';

/// Game state enumeration
enum GameState {
  menu,
  playing,
  paused,
  gameOver,
}

/// Power-up types
enum PowerUpType {
  magnet,
  shield,
  jetpack,
  doubleScore,
}

/// Obstacle types
enum ObstacleType {
  car,
  barrier,
  cone,
}

/// Lane positions
enum Lane {
  left,
  center,
  right,
}

/// Game constants
class GameConstants {
  // Colors - Colorful theme matching Subway Surfers style
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFF6B9D);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFF1A1A2E);
  static const Color cardColor = Color(0xFF16213E);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color roadColor = Color(0xFF424242);
  static const Color grassColor = Color(0xFF4CAF50);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF5A52E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B9D), Color(0xFFFF8E53)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Game dimensions
  static const double gameWidth = 400.0;
  static const double gameHeight = 800.0;
  static const double laneWidth = 100.0;
  
  // Player constants
  static const double playerWidth = 60.0;
  static const double playerHeight = 80.0;
  static const double jumpHeight = 150.0;
  static const double jumpDuration = 0.5;
  static const double slideDuration = 0.5;
  
  // Game mechanics
  static const double baseSpeed = 300.0;
  static const double maxSpeed = 800.0;
  static const double speedIncrement = 10.0;
  static const double speedIncrementInterval = 5.0; // seconds
  
  // Scoring
  static const int coinValue = 10;
  static const int distanceMultiplier = 1;
  
  // Spawn rates (seconds)
  static const double obstacleSpawnInterval = 1.5;
  static const double coinSpawnInterval = 0.5;
  static const double powerUpSpawnInterval = 10.0;
  
  // Power-up durations (seconds)
  static const double magnetDuration = 5.0;
  static const double shieldDuration = 8.0;
  static const double jetpackDuration = 3.0;
  static const double doubleScoreDuration = 10.0;
  
  // Power-up colors
  static const Map<PowerUpType, Color> powerUpColors = {
    PowerUpType.magnet: Color(0xFF2196F3),
    PowerUpType.shield: Color(0xFF4CAF50),
    PowerUpType.jetpack: Color(0xFFFF9800),
    PowerUpType.doubleScore: Color(0xFFFFC107),
  };
  
  // Obstacle colors
  static const Map<ObstacleType, Color> obstacleColors = {
    ObstacleType.car: Color(0xFFE91E63),
    ObstacleType.barrier: Color(0xFFFF5722),
    ObstacleType.cone: Color(0xFFFF9800),
  };
  
  // Audio
  static const double defaultMusicVolume = 0.5;
  static const double defaultSfxVolume = 0.7;
  
  // Preferences keys
  static const String prefKeyHighScore = 'high_score';
  static const String prefKeyTotalCoins = 'total_coins';
  static const String prefKeyMusicEnabled = 'music_enabled';
  static const String prefKeySfxEnabled = 'sfx_enabled';
  static const String prefKeyMusicVolume = 'music_volume';
  static const String prefKeySfxVolume = 'sfx_volume';
}

/// Lane helper extension
extension LaneExtension on Lane {
  /// Get x position for lane
  double get xPosition {
    switch (this) {
      case Lane.left:
        return GameConstants.gameWidth / 2 - GameConstants.laneWidth;
      case Lane.center:
        return GameConstants.gameWidth / 2;
      case Lane.right:
        return GameConstants.gameWidth / 2 + GameConstants.laneWidth;
    }
  }
  
  /// Get next lane to the left
  Lane? get left {
    switch (this) {
      case Lane.left:
        return null;
      case Lane.center:
        return Lane.left;
      case Lane.right:
        return Lane.center;
    }
  }
  
  /// Get next lane to the right
  Lane? get right {
    switch (this) {
      case Lane.left:
        return Lane.center;
      case Lane.center:
        return Lane.right;
      case Lane.right:
        return null;
    }
  }
}
