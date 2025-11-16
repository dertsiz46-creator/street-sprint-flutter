import 'package:flame/game.dart';
import '../../utils/constants.dart';

/// Game configuration and settings
class GameConfig {
  // World dimensions
  static Vector2 get worldSize => Vector2(
    GameConstants.gameWidth,
    GameConstants.gameHeight,
  );

  // Lane positions in world coordinates
  static List<double> get lanePositions => [
    GameConstants.gameWidth / 2 - GameConstants.laneWidth,  // Left lane
    GameConstants.gameWidth / 2,                             // Center lane
    GameConstants.gameWidth / 2 + GameConstants.laneWidth,  // Right lane
  ];

  // Player configuration
  static const double playerStartY = 600.0;
  static const double playerWidth = GameConstants.playerWidth;
  static const double playerHeight = GameConstants.playerHeight;
  static const double laneSwitchDuration = 0.2;

  // Jump configuration
  static const double jumpHeight = GameConstants.jumpHeight;
  static const double jumpDuration = GameConstants.jumpDuration;
  static const double gravity = 1000.0;

  // Slide configuration
  static const double slideHeight = 40.0;
  static const double slideDuration = GameConstants.slideDuration;

  // Game speed configuration
  static const double initialSpeed = GameConstants.baseSpeed;
  static const double maxSpeed = GameConstants.maxSpeed;
  static const double speedIncrement = GameConstants.speedIncrement;
  static const double speedIncrementInterval = GameConstants.speedIncrementInterval;

  // Spawn configuration
  static const double obstacleSpawnInterval = GameConstants.obstacleSpawnInterval;
  static const double coinSpawnInterval = GameConstants.coinSpawnInterval;
  static const double powerUpSpawnInterval = GameConstants.powerUpSpawnInterval;
  
  // Spawn Y position (off screen at top)
  static const double spawnY = -100.0;

  // Obstacle configuration
  static const double obstacleWidth = 70.0;
  static const double obstacleHeight = 80.0;
  static const double obstacleMinGap = 200.0;

  // Coin configuration
  static const double coinSize = 30.0;
  static const double coinSpacing = 50.0;
  static const int coinClusterSize = 5;
  static const double magnetRadius = 150.0;

  // Power-up configuration
  static const double powerUpSize = 40.0;
  static const double magnetDuration = GameConstants.magnetDuration;
  static const double shieldDuration = GameConstants.shieldDuration;
  static const double jetpackDuration = GameConstants.jetpackDuration;
  static const double doubleScoreDuration = GameConstants.doubleScoreDuration;

  // Road configuration
  static const double roadLineWidth = 5.0;
  static const double roadLineHeight = 40.0;
  static const double roadLineSpacing = 60.0;

  // Collision detection
  static const double collisionTolerance = 0.7; // 70% of size for more forgiving collisions

  // Score calculation
  static const int coinScore = GameConstants.coinValue;
  static const int distanceScore = GameConstants.distanceMultiplier;
  static const double scoreUpdateInterval = 0.1; // Update score every 0.1 seconds

  // Visual effects
  static const double particleLifetime = 1.0;
  static const int maxParticles = 50;
}
