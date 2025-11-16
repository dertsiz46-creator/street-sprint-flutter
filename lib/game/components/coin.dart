import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import '../config/game_config.dart';

/// Collectible coin component
class Coin extends PositionComponent with CollisionCallbacks {
  double speed = GameConfig.initialSpeed;
  bool collected = false;
  bool magnetized = false;
  Vector2? targetPosition;

  Coin({
    required Vector2 position,
  }) : super(
    position: position,
    size: Vector2.all(GameConfig.coinSize),
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
    
    // If magnetized, move towards target
    if (magnetized && targetPosition != null) {
      final direction = (targetPosition! - position).normalized();
      position += direction * speed * 2 * dt;
    } else {
      // Normal downward movement
      position.y += speed * dt;
    }
    
    // Remove if off screen
    if (position.y > GameConfig.worldSize.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    if (collected) return;
    
    // Draw coin as golden circle
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y))
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
    
    // Inner circle
    final innerPaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 3, innerPaint);
    
    // Currency symbol
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '\$',
        style: TextStyle(
          color: Color(0xFFFF9800),
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
  }

  /// Collect this coin
  void collect() {
    collected = true;
    removeFromParent();
  }

  /// Activate magnet effect on this coin
  void activateMagnet(Vector2 target) {
    magnetized = true;
    targetPosition = target;
  }

  /// Update coin speed
  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }
}
