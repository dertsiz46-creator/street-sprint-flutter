import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../config/game_config.dart';
import '../colorful_city_game.dart';
import 'obstacle.dart';
import 'coin.dart';
import 'powerup.dart';

/// Player character component
class Player extends PositionComponent with HasGameRef<ColorfulCityGame>, CollisionCallbacks {
  Lane _currentLane = Lane.center;
  bool _isJumping = false;
  bool _isSliding = false;
  bool _hasShield = false;
  
  double _targetX = 0.0;
  double _targetY = GameConfig.playerStartY;
  double _jumpTimer = 0.0;
  double _slideTimer = 0.0;
  double _initialJumpY = 0.0;

  Lane get currentLane => _currentLane;
  bool get isJumping => _isJumping;
  bool get isSliding => _isSliding;
  bool get hasShield => _hasShield;

  Player() : super(
    size: Vector2(GameConfig.playerWidth, GameConfig.playerHeight),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    _targetX = _currentLane.xPosition;
    position = Vector2(_targetX, GameConfig.playerStartY);
    
    // Add collision detection
    add(RectangleHitbox(
      size: size * GameConfig.collisionTolerance,
      anchor: Anchor.center,
      position: size / 2,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Smooth lane switching
    if ((position.x - _targetX).abs() > 1) {
      final direction = _targetX > position.x ? 1 : -1;
      position.x += direction * GameConfig.playerWidth * 10 * dt;
    } else {
      position.x = _targetX;
    }
    
    // Handle jumping
    if (_isJumping) {
      _jumpTimer += dt;
      
      if (_jumpTimer >= GameConfig.jumpDuration) {
        // Landing
        _isJumping = false;
        _jumpTimer = 0.0;
        position.y = _targetY;
      } else {
        // Arc motion using sine wave
        final progress = _jumpTimer / GameConfig.jumpDuration;
        final jumpHeight = sin(progress * pi) * GameConfig.jumpHeight;
        position.y = _initialJumpY - jumpHeight;
      }
    }
    
    // Handle sliding
    if (_isSliding) {
      _slideTimer += dt;
      
      if (_slideTimer >= GameConfig.slideDuration) {
        // End slide
        _isSliding = false;
        _slideTimer = 0.0;
        size.y = GameConfig.playerHeight;
        position.y = _targetY;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw player as colorful rounded rectangle
    final paint = Paint()
      ..shader = GameConstants.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, size.x, size.y),
      )
      ..style = PaintingStyle.fill;
    
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(10),
    );
    canvas.drawRRect(rect, paint);
    
    // Draw shield if active
    if (_hasShield) {
      final shieldPaint = Paint()
        ..color = GameConstants.powerUpColors[PowerUpType.shield]!.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(-5, -5, size.x + 10, size.y + 10),
          const Radius.circular(15),
        ),
        shieldPaint,
      );
    }
    
    // Draw eyes
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(size.x * 0.35, size.y * 0.3), 5, eyePaint);
    canvas.drawCircle(Offset(size.x * 0.65, size.y * 0.3), 5, eyePaint);
    
    final pupilPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(size.x * 0.35, size.y * 0.3), 2, pupilPaint);
    canvas.drawCircle(Offset(size.x * 0.65, size.y * 0.3), 2, pupilPaint);
  }

  /// Move to left lane
  void moveLeft() {
    final newLane = _currentLane.left;
    if (newLane != null && !_isSliding) {
      _currentLane = newLane;
      _targetX = _currentLane.xPosition;
    }
  }

  /// Move to right lane
  void moveRight() {
    final newLane = _currentLane.right;
    if (newLane != null && !_isSliding) {
      _currentLane = newLane;
      _targetX = _currentLane.xPosition;
    }
  }

  /// Jump
  void jump() {
    if (!_isJumping && !_isSliding) {
      _isJumping = true;
      _jumpTimer = 0.0;
      _initialJumpY = position.y;
    }
  }

  /// Slide
  void slide() {
    if (!_isSliding && !_isJumping) {
      _isSliding = true;
      _slideTimer = 0.0;
      size.y = GameConfig.slideHeight;
      position.y = _targetY + (GameConfig.playerHeight - GameConfig.slideHeight);
    }
  }

  /// Activate shield power-up
  void activateShield() {
    _hasShield = true;
  }

  /// Deactivate shield power-up
  void deactivateShield() {
    _hasShield = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if (other is Obstacle) {
      gameRef.handleCollision(other);
    } else if (other is Coin) {
      gameRef.handleCollision(other);
    } else if (other is PowerUp) {
      gameRef.handleCollision(other);
    }
  }

  /// Reset player for new game
  void reset() {
    _currentLane = Lane.center;
    _targetX = _currentLane.xPosition;
    position = Vector2(_targetX, GameConfig.playerStartY);
    _isJumping = false;
    _isSliding = false;
    _hasShield = false;
    _jumpTimer = 0.0;
    _slideTimer = 0.0;
    size.y = GameConfig.playerHeight;
  }
}
