import 'dart:async';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'config/game_config.dart';
import 'components/player.dart';
import 'components/obstacle.dart';
import 'components/coin.dart';
import 'components/powerup.dart';
import 'components/road.dart';
import 'managers/spawn_manager.dart';
import 'managers/score_manager.dart';

/// Main Flame game class for Street Sprint
class ColorfulCityGame extends FlameGame with HasCollisionDetection, PanDetector {
  // Callbacks
  Function(int score, int coins)? onScoreUpdate;
  Function()? onGameOver;
  Function(PowerUpType type, double duration)? onPowerUpCollected;
  
  // Game state
  bool _isGameOver = false;
  bool _isPaused = false;
  
  // Game components
  late Player _player;
  late Road _road;
  
  // Managers
  final SpawnManager _spawnManager = SpawnManager();
  final ScoreManager _scoreManager = ScoreManager();
  
  // Game speed
  double _currentSpeed = GameConfig.initialSpeed;
  double _speedTimer = 0.0;
  
  // Power-up states
  bool _magnetActive = false;
  bool _shieldActive = false;
  bool _jetpackActive = false;
  double _magnetTimer = 0.0;
  double _shieldTimer = 0.0;
  double _jetpackTimer = 0.0;
  
  // Swipe detection
  Vector2? _swipeStart;
  static const double _swipeThreshold = 50.0;

  ColorfulCityGame();

  @override
  Color backgroundColor() => GameConstants.backgroundColor;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Set camera to fixed size using CameraComponent with FixedResolutionViewport
    camera.viewport = FixedResolutionViewport(resolution: GameConfig.worldSize);
    
    // Initialize game components
    _road = Road();
    await add(_road);
    
    _player = Player();
    await add(_player);
    
    // Reset managers
    _spawnManager.reset();
    _scoreManager.reset();
  }

  @override
  void update(double dt) {
    if (_isPaused || _isGameOver) {
      return;
    }
    
    super.update(dt);
    
    // Update managers
    _spawnManager.update(dt);
    _scoreManager.update(dt);
    
    // Increase speed over time
    _speedTimer += dt;
    if (_speedTimer >= GameConfig.speedIncrementInterval) {
      _speedTimer = 0.0;
      if (_currentSpeed < GameConfig.maxSpeed) {
        _currentSpeed += GameConfig.speedIncrement;
        _updateGameSpeed();
      }
    }
    
    // Update power-up timers
    _updatePowerUpTimers(dt);
    
    // Spawn game objects
    _handleSpawning();
    
    // Update score callback
    if (onScoreUpdate != null) {
      onScoreUpdate!(_scoreManager.score, _scoreManager.coins);
    }
  }

  void _updatePowerUpTimers(double dt) {
    // Magnet timer
    if (_magnetActive) {
      _magnetTimer += dt;
      if (_magnetTimer >= GameConfig.magnetDuration) {
        _magnetActive = false;
        _magnetTimer = 0.0;
      } else {
        _attractCoins();
      }
    }
    
    // Shield timer
    if (_shieldActive) {
      _shieldTimer += dt;
      if (_shieldTimer >= GameConfig.shieldDuration) {
        _shieldActive = false;
        _shieldTimer = 0.0;
        _player.deactivateShield();
      }
    }
    
    // Jetpack timer (visual effect only)
    if (_jetpackActive) {
      _jetpackTimer += dt;
      if (_jetpackTimer >= GameConfig.jetpackDuration) {
        _jetpackActive = false;
        _jetpackTimer = 0.0;
      }
    }
    
    // Double score is handled by ScoreManager
  }

  void _attractCoins() {
    // Find all coins and attract them towards player
    final coins = children.whereType<Coin>();
    for (final coin in coins) {
      final distance = (coin.position - _player.position).length;
      if (distance < GameConfig.magnetRadius) {
        coin.activateMagnet(_player.position);
      }
    }
  }

  void _handleSpawning() {
    // Spawn obstacles
    if (_spawnManager.shouldSpawnObstacle() && _spawnManager.isSafeToSpawn()) {
      final obstacle = _spawnManager.createObstacle();
      obstacle.updateSpeed(_currentSpeed);
      add(obstacle);
    }
    
    // Spawn coins
    if (_spawnManager.shouldSpawnCoin()) {
      final coins = _spawnManager.createCoinCluster();
      for (final coin in coins) {
        coin.updateSpeed(_currentSpeed);
        add(coin);
      }
    }
    
    // Spawn power-ups
    if (_spawnManager.shouldSpawnPowerUp()) {
      final powerUp = _spawnManager.createPowerUp();
      powerUp.updateSpeed(_currentSpeed);
      add(powerUp);
    }
  }

  void _updateGameSpeed() {
    _road.updateSpeed(_currentSpeed);
    
    // Update all existing obstacles
    for (final obstacle in children.whereType<Obstacle>()) {
      obstacle.updateSpeed(_currentSpeed);
    }
    
    // Update all existing coins
    for (final coin in children.whereType<Coin>()) {
      coin.updateSpeed(_currentSpeed);
    }
    
    // Update all existing power-ups
    for (final powerUp in children.whereType<PowerUp>()) {
      powerUp.updateSpeed(_currentSpeed);
    }
  }

  @override
  void onPanStart(DragStartEvent info) {
    _swipeStart = info.canvasPosition;
  }

  @override
  void onPanUpdate(DragUpdateEvent info) {
    if (_swipeStart == null || _isPaused || _isGameOver) return;
    
    final delta = info.canvasPosition - _swipeStart!;
    
    // Horizontal swipe
    if (delta.x.abs() > _swipeThreshold && delta.x.abs() > delta.y.abs()) {
      if (delta.x > 0) {
        _player.moveRight();
      } else {
        _player.moveLeft();
      }
      _swipeStart = null;
    }
    // Vertical swipe up (jump)
    else if (delta.y < -_swipeThreshold && delta.y.abs() > delta.x.abs()) {
      _player.jump();
      _swipeStart = null;
    }
    // Vertical swipe down (slide)
    else if (delta.y > _swipeThreshold && delta.y.abs() > delta.x.abs()) {
      _player.slide();
      _swipeStart = null;
    }
  }

  @override
  void onPanEnd(DragEndEvent info) {
    _swipeStart = null;
  }

  /// Handle collision between player and other objects
  void handleCollision(PositionComponent other) {
    if (_isGameOver) return;
    
    if (other is Obstacle) {
      // Check if player has shield
      if (_shieldActive) {
        // Shield protects from collision
        other.removeFromParent();
        return;
      }
      
      // Check if player is jumping over obstacle
      if (_player.isJumping && _player.position.y < other.position.y - 40) {
        return;
      }
      
      // Check if player is sliding under obstacle
      if (_player.isSliding && other.type != ObstacleType.barrier) {
        return;
      }
      
      // Collision - game over
      _gameOver();
    }
    else if (other is Coin) {
      if (!other.collected) {
        other.collect();
        _scoreManager.collectCoin();
      }
    }
    else if (other is PowerUp) {
      if (!other.collected) {
        other.collect();
        _activatePowerUp(other.type, other.getDuration());
      }
    }
  }

  void _activatePowerUp(PowerUpType type, double duration) {
    if (onPowerUpCollected != null) {
      onPowerUpCollected!(type, duration);
    }
    
    switch (type) {
      case PowerUpType.magnet:
        _magnetActive = true;
        _magnetTimer = 0.0;
        break;
      case PowerUpType.shield:
        _shieldActive = true;
        _shieldTimer = 0.0;
        _player.activateShield();
        break;
      case PowerUpType.jetpack:
        _jetpackActive = true;
        _jetpackTimer = 0.0;
        break;
      case PowerUpType.doubleScore:
        _scoreManager.activateDoubleScore();
        Future.delayed(Duration(seconds: duration.toInt()), () {
          _scoreManager.deactivateDoubleScore();
        });
        break;
    }
  }

  void _gameOver() {
    if (_isGameOver) return;
    
    _isGameOver = true;
    pauseEngine();
    
    if (onGameOver != null) {
      onGameOver!();
    }
  }

  /// Reset game for new play session
  void resetGame() {
    _isGameOver = false;
    _isPaused = false;
    _currentSpeed = GameConfig.initialSpeed;
    _speedTimer = 0.0;
    
    // Reset power-ups
    _magnetActive = false;
    _shieldActive = false;
    _jetpackActive = false;
    _magnetTimer = 0.0;
    _shieldTimer = 0.0;
    _jetpackTimer = 0.0;
    
    // Reset managers
    _spawnManager.reset();
    _scoreManager.reset();
    
    // Remove all game objects
    children.whereType<Obstacle>().forEach((o) => o.removeFromParent());
    children.whereType<Coin>().forEach((c) => c.removeFromParent());
    children.whereType<PowerUp>().forEach((p) => p.removeFromParent());
    
    // Reset components
    _player.reset();
    _road.reset();
    
    resumeEngine();
  }

  /// Pause the game
  void pauseGame() {
    _isPaused = true;
    pauseEngine();
  }

  /// Resume the game
  void resumeGame() {
    _isPaused = false;
    resumeEngine();
  }

  /// Get current score
  int get currentScore => _scoreManager.score;
  
  /// Get current coins
  int get currentCoins => _scoreManager.coins;
}
