import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

/// Manages all game audio including music and sound effects
class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _musicEnabled = true;
  bool _sfxEnabled = true;
  double _musicVolume = GameConstants.defaultMusicVolume;
  double _sfxVolume = GameConstants.defaultSfxVolume;
  bool _initialized = false;

  bool get musicEnabled => _musicEnabled;
  bool get sfxEnabled => _sfxEnabled;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  /// Initialize audio system and load preferences
  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      _musicEnabled = prefs.getBool(GameConstants.prefKeyMusicEnabled) ?? true;
      _sfxEnabled = prefs.getBool(GameConstants.prefKeySfxEnabled) ?? true;
      _musicVolume = prefs.getDouble(GameConstants.prefKeyMusicVolume) ?? 
                     GameConstants.defaultMusicVolume;
      _sfxVolume = prefs.getDouble(GameConstants.prefKeySfxVolume) ?? 
                   GameConstants.defaultSfxVolume;
      
      await _musicPlayer.setVolume(_musicVolume);
      await _sfxPlayer.setVolume(_sfxVolume);
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      
      _initialized = true;
    } catch (e) {
      print('AudioManager initialization error: $e');
      // Continue without audio rather than crashing
      _initialized = true;
    }
  }

  /// Play background music
  Future<void> playMusic(String assetPath) async {
    if (!_musicEnabled) return;
    
    try {
      await _musicPlayer.stop();
      await _musicPlayer.play(AssetSource(assetPath));
    } catch (e) {
      print('Music playback error: $e');
      // Fail silently if asset doesn't exist
    }
  }

  /// Play sound effect
  Future<void> playSfx(String assetPath) async {
    if (!_sfxEnabled) return;
    
    try {
      await _sfxPlayer.play(AssetSource(assetPath));
    } catch (e) {
      print('SFX playback error: $e');
      // Fail silently if asset doesn't exist
    }
  }

  /// Stop background music
  Future<void> stopMusic() async {
    try {
      await _musicPlayer.stop();
    } catch (e) {
      print('Stop music error: $e');
    }
  }

  /// Pause background music
  Future<void> pauseMusic() async {
    try {
      await _musicPlayer.pause();
    } catch (e) {
      print('Pause music error: $e');
    }
  }

  /// Resume background music
  Future<void> resumeMusic() async {
    if (!_musicEnabled) return;
    
    try {
      await _musicPlayer.resume();
    } catch (e) {
      print('Resume music error: $e');
    }
  }

  /// Toggle music on/off
  Future<void> toggleMusic() async {
    _musicEnabled = !_musicEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(GameConstants.prefKeyMusicEnabled, _musicEnabled);
    
    if (!_musicEnabled) {
      await stopMusic();
    }
  }

  /// Toggle sound effects on/off
  Future<void> toggleSfx() async {
    _sfxEnabled = !_sfxEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(GameConstants.prefKeySfxEnabled, _sfxEnabled);
  }

  /// Set music volume (0.0 to 1.0)
  Future<void> setMusicVolume(double volume) async {
    _musicVolume = volume.clamp(0.0, 1.0);
    await _musicPlayer.setVolume(_musicVolume);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(GameConstants.prefKeyMusicVolume, _musicVolume);
  }

  /// Set sound effects volume (0.0 to 1.0)
  Future<void> setSfxVolume(double volume) async {
    _sfxVolume = volume.clamp(0.0, 1.0);
    await _sfxPlayer.setVolume(_sfxVolume);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(GameConstants.prefKeySfxVolume, _sfxVolume);
  }

  /// Clean up audio resources
  Future<void> dispose() async {
    await _musicPlayer.dispose();
    await _sfxPlayer.dispose();
  }
}
