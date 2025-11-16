import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../managers/game_manager.dart';
import '../utils/constants.dart';
import 'main_menu.dart';
import 'game_screen.dart';

/// Game over screen with score display and options
class GameOverScreen extends StatelessWidget {
  final int score;
  final int coins;

  const GameOverScreen({
    super.key,
    required this.score,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    final gameManager = context.watch<GameManager>();
    final isNewHighScore = score > gameManager.highScore;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: GameConstants.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game Over Title
                const Text(
                  'GAME OVER',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: GameConstants.textColor,
                    letterSpacing: 4,
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.8, 0.8)),
                
                const SizedBox(height: 40),
                
                // New High Score Banner
                if (isNewHighScore)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      gradient: GameConstants.goldGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: GameConstants.accentColor.withOpacity(0.7),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'NEW HIGH SCORE!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ).animate()
                    .fadeIn(delay: 300.ms)
                    .scale(begin: const Offset(0.5, 0.5))
                    .then()
                    .shimmer(duration: 2000.ms),
                
                if (isNewHighScore) const SizedBox(height: 30),
                
                // Score Display
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: GameConstants.cardColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: GameConstants.primaryColor.withOpacity(0.5),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: GameConstants.primaryColor.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'SCORE',
                        style: TextStyle(
                          fontSize: 20,
                          color: GameConstants.textColor,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: GameConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        color: GameConstants.primaryColor,
                        thickness: 2,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: GameConstants.accentColor,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$coins',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: GameConstants.accentColor,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'COINS',
                            style: TextStyle(
                              fontSize: 18,
                              color: GameConstants.textColor,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(delay: isNewHighScore ? 800.ms : 400.ms)
                  .slideY(begin: 0.3, end: 0),
                
                const SizedBox(height: 40),
                
                // High Score Display
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: GameConstants.cardColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: GameConstants.accentColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'BEST:',
                        style: TextStyle(
                          fontSize: 18,
                          color: GameConstants.textColor,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${gameManager.highScore}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: GameConstants.accentColor,
                        ),
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(delay: isNewHighScore ? 1000.ms : 600.ms),
                
                const SizedBox(height: 60),
                
                // Retry Button
                _GameButton(
                  onPressed: () {
                    gameManager.startGame();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  gradient: GameConstants.primaryGradient,
                  icon: Icons.replay,
                  text: 'RETRY',
                ).animate()
                  .fadeIn(delay: isNewHighScore ? 1200.ms : 800.ms)
                  .slideX(begin: -0.2),
                
                const SizedBox(height: 20),
                
                // Menu Button
                _GameButton(
                  onPressed: () {
                    gameManager.returnToMenu();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    );
                  },
                  gradient: GameConstants.secondaryGradient,
                  icon: Icons.home,
                  text: 'MENU',
                ).animate()
                  .fadeIn(delay: isNewHighScore ? 1400.ms : 1000.ms)
                  .slideX(begin: 0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Game button widget for game over screen
class _GameButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Gradient gradient;
  final IconData icon;
  final String text;

  const _GameButton({
    required this.onPressed,
    required this.gradient,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
