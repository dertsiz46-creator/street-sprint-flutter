import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../managers/game_manager.dart';
import '../utils/constants.dart';
import 'game_screen.dart';

/// Main menu screen with animated UI
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final gameManager = context.watch<GameManager>();
    
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
                // Title
                const Text(
                  'STREET',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: GameConstants.textColor,
                    letterSpacing: 8,
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.3, end: 0),
                
                const Text(
                  'SPRINT',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: GameConstants.textColor,
                    letterSpacing: 8,
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.3, end: 0),
                
                const SizedBox(height: 20),
                
                // Subtitle
                const Text(
                  'Endless Runner',
                  style: TextStyle(
                    fontSize: 20,
                    color: GameConstants.accentColor,
                    letterSpacing: 2,
                  ),
                ).animate()
                  .fadeIn(delay: 400.ms),
                
                const SizedBox(height: 60),
                
                // High Score Display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: GameConstants.goldGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: GameConstants.accentColor.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'HIGH SCORE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${gameManager.highScore}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(delay: 600.ms)
                  .scale(begin: const Offset(0.8, 0.8)),
                
                const SizedBox(height: 30),
                
                // Coins Display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    color: GameConstants.cardColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: GameConstants.accentColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: GameConstants.accentColor,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${gameManager.totalCoins}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: GameConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(delay: 800.ms)
                  .slideX(begin: -0.2),
                
                const SizedBox(height: 60),
                
                // Play Button
                _GradientButton(
                  onPressed: () {
                    gameManager.startGame();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  gradient: GameConstants.primaryGradient,
                  child: const Text(
                    'PLAY',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ).animate()
                  .fadeIn(delay: 1000.ms)
                  .scale(begin: const Offset(0.8, 0.8))
                  .then()
                  .shimmer(duration: 2000.ms, delay: 500.ms),
                
                const SizedBox(height: 20),
                
                // Settings/Audio Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _IconButton(
                      icon: gameManager.audioManager.musicEnabled 
                        ? Icons.music_note 
                        : Icons.music_off,
                      onPressed: () async {
                        await gameManager.audioManager.toggleMusic();
                      },
                    ),
                    const SizedBox(width: 20),
                    _IconButton(
                      icon: gameManager.audioManager.sfxEnabled 
                        ? Icons.volume_up 
                        : Icons.volume_off,
                      onPressed: () async {
                        await gameManager.audioManager.toggleSfx();
                      },
                    ),
                  ],
                ).animate()
                  .fadeIn(delay: 1200.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Gradient button widget
class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Gradient gradient;
  final Widget child;

  const _GradientButton({
    required this.onPressed,
    required this.gradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: GameConstants.primaryColor.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Icon button widget
class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _IconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GameConstants.cardColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: GameConstants.primaryColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: GameConstants.primaryColor),
        iconSize: 30,
        onPressed: onPressed,
      ),
    );
  }
}
