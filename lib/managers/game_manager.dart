import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../utils/audio_manager.dart';

/// Manages overall game state and persistent data
class GameManager extends ChangeNotifier {
  GameState _gameState = GameState.menu;
  int _currentScore = 0;
  int _highScore = 0;
  int _totalCoins = 0;
  int _currentCoins = 0;
  bool _isPaused = false;

  final AudioManager _audioManager = AudioManager();

  GameState get gameState => _gameState;
  int get currentScore => _currentScore;
  int get highScore => _highScore;
  int get totalCoins => _totalCoins;
  int get currentCoins => _currentCoins;
  bool get isPaused => _isPaused;

  /// Initialize game manager and load saved data
  Future<void> initialize() async {
    await _audioManager.initialize();
    await _loadGameData();
    notifyListeners();
  }

  /// Load saved game data from SharedPreferences
  Future<void> _loadGameData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _highScore = prefs.getInt(GameConstants.prefKeyHighScore) ?? 0;
      _totalCoins = prefs.getInt(GameConstants.prefKeyTotalCoins) ?? 0;
    } catch (e) {
      print('Error loading game data: $e');
      _highScore = 0;
      _totalCoins = 0;
    }
  }

  /// Save game data to SharedPreferences
  Future<void> _saveGameData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(GameConstants.prefKeyHighScore, _highScore);
      await prefs.setInt(GameConstants.prefKeyTotalCoins, _totalCoins);
    } catch (e) {
      print('Error saving game data: $e');
    }
  }

  /// Start a new game
  void startGame() {
    _gameState = GameState.playing;
    _currentScore = 0;
    _currentCoins = 0;
    _isPaused = false;
    _audioManager.playSfx('audio/sfx/game_start.mp3');
    notifyListeners();
  }

  /// Pause the game
  void pauseGame() {
    if (_gameState != GameState.playing) return;
    
    _isPaused = true;
    _gameState = GameState.paused;
    _audioManager.pauseMusic();
    notifyListeners();
  }

  /// Resume the game
  void resumeGame() {
    if (_gameState != GameState.paused) return;
    
    _isPaused = false;
    _gameState = GameState.playing;
    _audioManager.resumeMusic();
    notifyListeners();
  }

  /// End the game
  Future<void> gameOver() async {
    if (_gameState == GameState.gameOver) return;
    
    _gameState = GameState.gameOver;
    _isPaused = false;
    
    // Update high score if needed
    if (_currentScore > _highScore) {
      _highScore = _currentScore;
      await _saveGameData();
    }
    
    // Add collected coins to total
    _totalCoins += _currentCoins;
    await _saveGameData();
    
    _audioManager.playSfx('audio/sfx/game_over.mp3');
    notifyListeners();
  }

  /// Return to main menu
  void returnToMenu() {
    _gameState = GameState.menu;
    _currentScore = 0;
    _currentCoins = 0;
    _isPaused = false;
    notifyListeners();
  }

  /// Update current score
  void updateScore(int score) {
    _currentScore = score;
    notifyListeners();
  }

  /// Add coins collected in current run
  void addCoins(int coins) {
    _currentCoins += coins;
    notifyListeners();
  }

  /// Add score points
  void addScore(int points) {
    _currentScore += points;
    notifyListeners();
  }

  /// Get audio manager instance
  AudioManager get audioManager => _audioManager;
}
