import '../config/game_config.dart';

/// Manages game scoring and distance tracking
class ScoreManager {
  int _score = 0;
  int _coins = 0;
  double _distance = 0.0;
  double _scoreTimer = 0.0;
  bool _doubleScoreActive = false;

  int get score => _score;
  int get coins => _coins;
  double get distance => _distance;
  bool get doubleScoreActive => _doubleScoreActive;

  /// Reset score for new game
  void reset() {
    _score = 0;
    _coins = 0;
    _distance = 0.0;
    _scoreTimer = 0.0;
    _doubleScoreActive = false;
  }

  /// Update score based on time passed
  void update(double dt) {
    _scoreTimer += dt;
    
    // Update score based on distance every interval
    if (_scoreTimer >= GameConfig.scoreUpdateInterval) {
      final points = (GameConfig.distanceScore * 
                     (_doubleScoreActive ? 2 : 1)).toInt();
      _score += points;
      _scoreTimer = 0.0;
    }
  }

  /// Add score for collecting a coin
  void collectCoin() {
    _coins++;
    final points = GameConfig.coinScore * (_doubleScoreActive ? 2 : 1);
    _score += points;
  }

  /// Update distance traveled
  void updateDistance(double delta) {
    _distance += delta;
  }

  /// Activate double score power-up
  void activateDoubleScore() {
    _doubleScoreActive = true;
  }

  /// Deactivate double score power-up
  void deactivateDoubleScore() {
    _doubleScoreActive = false;
  }
}
