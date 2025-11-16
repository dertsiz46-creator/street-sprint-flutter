import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';
import '../managers/game_manager.dart';
import '../game/colorful_city_game.dart';
import '../utils/constants.dart';
import 'game_over_screen.dart';

/// Game screen that displays the Flame game
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late ColorfulCityGame _game;
  int _currentScore = 0;
  int _currentCoins = 0;
  String? _activePowerUp;
  double _powerUpTimeRemaining = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _game = ColorfulCityGame()
      ..onScoreUpdate = (score, coins) {
        if (mounted) {
          setState(() {
            _currentScore = score;
            _currentCoins = coins;
          });
        }
      }
      ..onGameOver = () {
        if (mounted) {
          _handleGameOver();
        }
      }
      ..onPowerUpCollected = (type, duration) {
        if (mounted) {
          setState(() {
            _activePowerUp = _getPowerUpName(type);
            _powerUpTimeRemaining = duration;
          });
          
          // Countdown timer for power-up display
          _countdownPowerUp(duration);
        }
      };
  }

  String _getPowerUpName(PowerUpType type) {
    switch (type) {
      case PowerUpType.magnet:
        return 'MAGNET';
      case PowerUpType.shield:
        return 'SHIELD';
      case PowerUpType.jetpack:
        return 'JETPACK';
      case PowerUpType.doubleScore:
        return '2X SCORE';
    }
  }

  void _countdownPowerUp(double duration) async {
    final steps = (duration * 10).toInt(); // Update every 0.1 seconds
    for (int i = 0; i < steps; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _powerUpTimeRemaining -= 0.1;
        });
      }
    }
    if (mounted) {
      setState(() {
        _activePowerUp = null;
        _powerUpTimeRemaining = 0;
      });
    }
  }

  void _handleGameOver() {
    final gameManager = context.read<GameManager>();
    gameManager.gameOver();
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GameOverScreen(
          score: _currentScore,
          coins: _currentCoins,
        ),
      ),
    );
  }

  void _pauseGame() {
    _game.pauseGame();
    _showPauseDialog();
  }

  void _showPauseDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: GameConstants.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'PAUSED',
          style: TextStyle(
            color: GameConstants.textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $_currentScore',
              style: const TextStyle(
                color: GameConstants.textColor,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Coins: $_currentCoins',
              style: const TextStyle(
                color: GameConstants.accentColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _game.resumeGame();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: GameConstants.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'RESUME',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<GameManager>().returnToMenu();
              Navigator.of(context).pop(); // Return to menu
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: GameConstants.cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: GameConstants.secondaryColor),
              ),
              child: const Text(
                'QUIT',
                style: TextStyle(
                  color: GameConstants.secondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(game: _game),
          
          // UI Overlay
          SafeArea(
            child: Column(
              children: [
                // Top bar with score and pause
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Score
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: GameConstants.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: GameConstants.primaryColor.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Text(
                          '$_currentScore',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      // Coins
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: GameConstants.goldGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: GameConstants.accentColor.withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.monetization_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$_currentCoins',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Pause button
                      IconButton(
                        icon: const Icon(Icons.pause),
                        color: Colors.white,
                        iconSize: 36,
                        onPressed: _pauseGame,
                      ),
                    ],
                  ),
                ),
                
                // Power-up indicator
                if (_activePowerUp != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: GameConstants.secondaryGradient,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: GameConstants.secondaryColor.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.flash_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '$_activePowerUp ${_powerUpTimeRemaining.toStringAsFixed(1)}s',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _game.pauseEngine();
    super.dispose();
  }
}
