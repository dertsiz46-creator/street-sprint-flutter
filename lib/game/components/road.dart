import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../config/game_config.dart';

/// Scrolling road background component
class Road extends PositionComponent {
  double speed = GameConfig.initialSpeed;
  final List<Vector2> _roadLines = [];
  double _lineOffset = 0.0;

  Road() : super(
    size: GameConfig.worldSize,
    position: Vector2.zero(),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Initialize road line positions
    final numLines = (GameConfig.worldSize.y / GameConfig.roadLineSpacing).ceil() + 1;
    for (int i = 0; i < numLines; i++) {
      _roadLines.add(Vector2(0, i * GameConfig.roadLineSpacing));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Scroll road lines
    _lineOffset += speed * dt;
    
    // Reset offset when it exceeds spacing
    if (_lineOffset >= GameConfig.roadLineSpacing) {
      _lineOffset -= GameConfig.roadLineSpacing;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw grass borders
    final grassPaint = Paint()
      ..color = GameConstants.grassColor
      ..style = PaintingStyle.fill;
    
    final roadWidth = GameConstants.laneWidth * 3 + 50;
    final roadLeft = (size.x - roadWidth) / 2;
    
    // Left grass
    canvas.drawRect(
      Rect.fromLTWH(0, 0, roadLeft, size.y),
      grassPaint,
    );
    
    // Right grass
    canvas.drawRect(
      Rect.fromLTWH(roadLeft + roadWidth, 0, roadLeft, size.y),
      grassPaint,
    );
    
    // Draw road
    final roadPaint = Paint()
      ..color = GameConstants.roadColor
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(roadLeft, 0, roadWidth, size.y),
      roadPaint,
    );
    
    // Draw lane dividers
    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    // Left lane divider
    final leftLaneX = roadLeft + roadWidth / 3;
    _drawDashedLine(canvas, linePaint, leftLaneX);
    
    // Right lane divider
    final rightLaneX = roadLeft + roadWidth * 2 / 3;
    _drawDashedLine(canvas, linePaint, rightLaneX);
    
    // Draw center lines
    final centerLinePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    
    final centerX = size.x / 2;
    _drawDashedLine(canvas, centerLinePaint, centerX);
  }

  void _drawDashedLine(Canvas canvas, Paint paint, double x) {
    final lineWidth = GameConfig.roadLineWidth;
    final lineHeight = GameConfig.roadLineHeight;
    
    for (final linePos in _roadLines) {
      final y = (linePos.y + _lineOffset) % (size.y + GameConfig.roadLineSpacing);
      canvas.drawRect(
        Rect.fromLTWH(
          x - lineWidth / 2,
          y,
          lineWidth,
          lineHeight,
        ),
        paint,
      );
    }
  }

  /// Update road scroll speed
  void updateSpeed(double newSpeed) {
    speed = newSpeed;
  }

  /// Reset road for new game
  void reset() {
    _lineOffset = 0.0;
    speed = GameConfig.initialSpeed;
  }
}
