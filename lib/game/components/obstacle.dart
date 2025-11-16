import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../config/game_config.dart';

/// Obstacle component
class Obstacle extends PositionComponent with CollisionCallbacks {
  final Lane lane;
  final ObstacleType type;
  double speed = GameConfig.initialSpeed;

  Obstacle({
    required this.lane,
    required this.type,
    required Vector2 position,
  }) : super(
    position: position,
    size: Vector2(GameConfig.obstacleWidth, GameConfig.obstacleHeight),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
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
    
    // Move obstacle down the screen
    position.y += speed * dt;
    
    // Remove if off screen
    if (position.y > GameConfig.worldSize.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Get color based on obstacle type
    final color = GameConstants.obstacleColors[type] ?? Colors.red;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // Draw different shapes based on type
    switch (type) {
      case ObstacleType.car:
        // Draw a simple car shape
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.x, size.y),
          const Radius.circular(8),
        );
        canvas.drawRRect(rect, paint);
        
        // Windows
        final windowPaint = Paint()
          ..color = Colors.lightBlue.withOpacity(0.5)
          ..style = PaintingStyle.fill;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(size.x * 0.2, size.y * 0.2, size.x * 0.6, size.y * 0.3),
            const Radius.circular(4),
          ),
          windowPaint,
        );
        
        // Wheels
        final wheelPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(size.x * 0.25, size.y * 0.85), 8, wheelPaint);
        canvas.drawCircle(Offset(size.x * 0.75, size.y * 0.85), 8, wheelPaint);
        break;
        
      case ObstacleType.barrier:
        // Draw striped barrier
        for (int i = 0; i < 4; i++) {
          final stripePaint = Paint()
            ..color = i % 2 == 0 ? color : Colors.white
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * size.y / 4, size.x, size.y / 4),
            stripePaint,
          );
        }
        break;
        
      case ObstacleType.cone:
        // Draw traffic cone
        final path = Path()
          ..moveTo(size.x / 2, 0)
          ..lineTo(0, size.y * 0.8)
          ..lineTo(size.x, size.y * 0.8)
          ..close();
        canvas.drawPath(path, paint);
        
        // Base
        final basePaint = Paint()
          ..color = Colors.grey[800]!
          ..style = PaintingStyle.fill;
        canvas.drawRect(
          Rect.fromLTWH(size.x * 0.2, size.y * 0.8, size.x * 0.6, size.y * 0.2),
          basePaint,
        );
        break;
    }
  }

  /// Update obstacle speed
  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }
}
