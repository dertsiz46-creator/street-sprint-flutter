import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../config/game_config.dart';

/// Power-up component
class PowerUp extends PositionComponent with CollisionCallbacks {
  final Lane lane;
  final PowerUpType type;
  double speed = GameConfig.initialSpeed;
  bool collected = false;

  PowerUp({
    required this.lane,
    required this.type,
    required Vector2 position,
  }) : super(
    position: position,
    size: Vector2.all(GameConfig.powerUpSize),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Add collision detection
    add(CircleHitbox(
      radius: size.x / 2 * GameConfig.collisionTolerance,
      anchor: Anchor.center,
      position: size / 2,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (collected) return;
    
    // Move power-up down the screen
    position.y += speed * dt;
    
    // Remove if off screen
    if (position.y > GameConfig.worldSize.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    if (collected) return;
    
    // Get color based on power-up type
    final color = GameConstants.powerUpColors[type] ?? Colors.blue;
    
    // Draw outer glow
    final glowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 1.5, glowPaint);
    
    // Draw power-up as colored circle
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
    
    // Draw icon based on type
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    switch (type) {
      case PowerUpType.magnet:
        // Draw magnet shape (U shape)
        final path = Path()
          ..moveTo(size.x * 0.3, size.y * 0.3)
          ..lineTo(size.x * 0.3, size.y * 0.6)
          ..quadraticBezierTo(
            size.x * 0.3, size.y * 0.8,
            size.x * 0.5, size.y * 0.8,
          )
          ..quadraticBezierTo(
            size.x * 0.7, size.y * 0.8,
            size.x * 0.7, size.y * 0.6,
          )
          ..lineTo(size.x * 0.7, size.y * 0.3);
        canvas.drawPath(path, iconPaint);
        break;
        
      case PowerUpType.shield:
        // Draw shield shape
        final path = Path()
          ..moveTo(size.x * 0.5, size.y * 0.25)
          ..lineTo(size.x * 0.7, size.y * 0.35)
          ..lineTo(size.x * 0.7, size.y * 0.6)
          ..lineTo(size.x * 0.5, size.y * 0.75)
          ..lineTo(size.x * 0.3, size.y * 0.6)
          ..lineTo(size.x * 0.3, size.y * 0.35)
          ..close();
        canvas.drawPath(path, iconPaint);
        break;
        
      case PowerUpType.jetpack:
        // Draw jetpack flame shape
        final path = Path()
          ..moveTo(size.x * 0.5, size.y * 0.3)
          ..lineTo(size.x * 0.4, size.y * 0.5)
          ..lineTo(size.x * 0.35, size.y * 0.7)
          ..lineTo(size.x * 0.5, size.y * 0.6)
          ..lineTo(size.x * 0.65, size.y * 0.7)
          ..lineTo(size.x * 0.6, size.y * 0.5)
          ..close();
        canvas.drawPath(path, iconPaint);
        break;
        
      case PowerUpType.doubleScore:
        // Draw 2x text
        final textPainter = TextPainter(
          text: const TextSpan(
            text: '2×',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            size.x / 2 - textPainter.width / 2,
            size.y / 2 - textPainter.height / 2,
          ),
        );
        break;
    }
  }

  /// Collect this power-up
  void collect() {
    collected = true;
    removeFromParent();
  }

  /// Update power-up speed
  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  /// Get duration for this power-up type
  double getDuration() {
    switch (type) {
      case PowerUpType.magnet:
        return GameConfig.magnetDuration;
      case PowerUpType.shield:
        return GameConfig.shieldDuration;
      case PowerUpType.jetpack:
        return GameConfig.jetpackDuration;
      case PowerUpType.doubleScore:
        return GameConfig.doubleScoreDuration;
    }
  }
}
