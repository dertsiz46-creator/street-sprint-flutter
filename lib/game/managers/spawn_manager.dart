import 'dart:math';
import 'package:flame/game.dart';
import '../../utils/constants.dart';
import '../config/game_config.dart';
import '../components/obstacle.dart';
import '../components/coin.dart';
import '../components/powerup.dart';

/// Manages spawning of game objects
class SpawnManager {
  final Random _random = Random();
  
  double _obstacleTimer = 0.0;
  double _coinTimer = 0.0;
  double _powerUpTimer = 0.0;
  
  Lane? _lastObstacleLane;
  double _lastObstacleY = 0.0;

  /// Reset spawn manager for new game
  void reset() {
    _obstacleTimer = 0.0;
    _coinTimer = 0.0;
    _powerUpTimer = 0.0;
    _lastObstacleLane = null;
    _lastObstacleY = 0.0;
  }

  /// Update spawn timers
  void update(double dt) {
    _obstacleTimer += dt;
    _coinTimer += dt;
    _powerUpTimer += dt;
  }

  /// Check if should spawn obstacle
  bool shouldSpawnObstacle() {
    if (_obstacleTimer >= GameConfig.obstacleSpawnInterval) {
      _obstacleTimer = 0.0;
      return true;
    }
    return false;
  }

  /// Check if should spawn coin
  bool shouldSpawnCoin() {
    if (_coinTimer >= GameConfig.coinSpawnInterval) {
      _coinTimer = 0.0;
      return true;
    }
    return false;
  }

  /// Check if should spawn power-up
  bool shouldSpawnPowerUp() {
    if (_powerUpTimer >= GameConfig.powerUpSpawnInterval) {
      _powerUpTimer = 0.0;
      return true;
    }
    return false;
  }

  /// Get random lane different from last obstacle
  Lane getRandomLane({bool avoidLast = true}) {
    final lanes = Lane.values;
    
    if (avoidLast && _lastObstacleLane != null) {
      final availableLanes = lanes.where((l) => l != _lastObstacleLane).toList();
      return availableLanes[_random.nextInt(availableLanes.length)];
    }
    
    return lanes[_random.nextInt(lanes.length)];
  }

  /// Get random obstacle type
  ObstacleType getRandomObstacleType() {
    final types = ObstacleType.values;
    return types[_random.nextInt(types.length)];
  }

  /// Get random power-up type
  PowerUpType getRandomPowerUpType() {
    final types = PowerUpType.values;
    return types[_random.nextInt(types.length)];
  }

  /// Create obstacle at random lane
  Obstacle createObstacle() {
    final lane = getRandomLane(avoidLast: true);
    final type = getRandomObstacleType();
    
    _lastObstacleLane = lane;
    _lastObstacleY = GameConfig.spawnY;
    
    return Obstacle(
      lane: lane,
      type: type,
      position: Vector2(lane.xPosition, GameConfig.spawnY),
    );
  }

  /// Create coin cluster at random lane
  List<Coin> createCoinCluster() {
    final lane = getRandomLane(avoidLast: false);
    final coins = <Coin>[];
    
    // Create vertical line of coins
    for (int i = 0; i < GameConfig.coinClusterSize; i++) {
      final y = GameConfig.spawnY - (i * GameConfig.coinSpacing);
      coins.add(Coin(
        position: Vector2(lane.xPosition, y),
      ));
    }
    
    return coins;
  }

  /// Create power-up at random lane
  PowerUp createPowerUp() {
    final lane = getRandomLane(avoidLast: false);
    final type = getRandomPowerUpType();
    
    return PowerUp(
      lane: lane,
      type: type,
      position: Vector2(lane.xPosition, GameConfig.spawnY),
    );
  }

  /// Check if safe to spawn (no overlap with last obstacle)
  bool isSafeToSpawn() {
    return GameConfig.spawnY - _lastObstacleY >= GameConfig.obstacleMinGap;
  }
}
