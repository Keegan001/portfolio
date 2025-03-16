import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends ChangeNotifier {
  // Game state
  bool _isPlaying = false;
  bool _isPaused = false;
  bool _isGameOver = false;
  
  // Game stats
  int _score = 0;
  int _highScore = 0;
  int _lives = 3;
  int _level = 1;
  
  // Player state
  Offset _playerPosition = const Offset(0, 0);
  bool _isPlayerMoving = false;
  bool _isPlayerFiring = false;
  
  // Game objects
  final List<AsteroidData> _asteroids = [];
  final List<LaserData> _lasers = [];
  
  // Game settings
  final int _maxAsteroids = 10;
  final double _asteroidSpawnRate = 1.5; // seconds
  final double _playerSpeed = 5.0;
  final double _laserSpeed = 10.0;
  
  // Timers
  Timer? _gameLoopTimer;
  Timer? _asteroidSpawnTimer;
  
  // Screen dimensions
  Size _screenSize = Size.zero;
  
  // Random generator
  final Random _random = Random();
  
  // Getters
  bool get isPlaying => _isPlaying;
  bool get isPaused => _isPaused;
  bool get isGameOver => _isGameOver;
  int get score => _score;
  int get highScore => _highScore;
  int get lives => _lives;
  int get level => _level;
  Offset get playerPosition => _playerPosition;
  bool get isPlayerMoving => _isPlayerMoving;
  bool get isPlayerFiring => _isPlayerFiring;
  List<AsteroidData> get asteroids => _asteroids;
  List<LaserData> get lasers => _lasers;
  
  // Initialize the game
  Future<void> initialize(Size screenSize) async {
    _screenSize = screenSize;
    
    // Center the player
    _playerPosition = Offset(
      screenSize.width / 2,
      screenSize.height - 100,
    );
    
    // Load high score
    await _loadHighScore();
    
    notifyListeners();
  }
  
  // Start the game
  void startGame() {
    if (_isPlaying) return;
    
    _isPlaying = true;
    _isPaused = false;
    _isGameOver = false;
    _score = 0;
    _lives = 3;
    _level = 1;
    _asteroids.clear();
    _lasers.clear();
    
    // Start game loop
    _startGameLoop();
    
    // Start asteroid spawning
    _startAsteroidSpawner();
    
    notifyListeners();
  }
  
  // Pause/resume the game
  void togglePause() {
    if (!_isPlaying || _isGameOver) return;
    
    _isPaused = !_isPaused;
    
    if (_isPaused) {
      _stopTimers();
    } else {
      _startGameLoop();
      _startAsteroidSpawner();
    }
    
    notifyListeners();
  }
  
  // End the game
  void endGame() {
    if (!_isPlaying) return;
    
    _isPlaying = false;
    _isPaused = false;
    _isGameOver = true;
    
    _stopTimers();
    
    // Update high score if needed
    if (_score > _highScore) {
      _highScore = _score;
      _saveHighScore();
    }
    
    notifyListeners();
  }
  
  // Move the player
  void movePlayer(Offset direction) {
    if (!_isPlaying || _isPaused || _isGameOver) return;
    
    final double dx = direction.dx * _playerSpeed;
    final double dy = direction.dy * _playerSpeed;
    
    // Calculate new position
    double newX = _playerPosition.dx + dx;
    double newY = _playerPosition.dy + dy;
    
    // Constrain to screen bounds
    newX = newX.clamp(50, _screenSize.width - 50);
    newY = newY.clamp(50, _screenSize.height - 50);
    
    _playerPosition = Offset(newX, newY);
    _isPlayerMoving = dx != 0 || dy != 0;
    
    notifyListeners();
  }
  
  // Fire a laser
  void fireLaser() {
    if (!_isPlaying || _isPaused || _isGameOver) return;
    
    _isPlayerFiring = true;
    
    // Create a new laser
    final laser = LaserData(
      position: Offset(_playerPosition.dx, _playerPosition.dy - 30),
      velocity: const Offset(0, -1),
      speed: _laserSpeed,
    );
    
    _lasers.add(laser);
    
    // Reset firing state after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      _isPlayerFiring = false;
      notifyListeners();
    });
    
    notifyListeners();
  }
  
  // Game loop
  void _startGameLoop() {
    _gameLoopTimer?.cancel();
    _gameLoopTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_isPaused || _isGameOver) return;
      
      _updateGame();
      notifyListeners();
    });
  }
  
  // Asteroid spawner
  void _startAsteroidSpawner() {
    _asteroidSpawnTimer?.cancel();
    _asteroidSpawnTimer = Timer.periodic(
      Duration(milliseconds: (_asteroidSpawnRate * 1000 / _level).round()),
      (timer) {
        if (_isPaused || _isGameOver) return;
        
        if (_asteroids.length < _maxAsteroids) {
          _spawnAsteroid();
        }
      },
    );
  }
  
  // Spawn a new asteroid
  void _spawnAsteroid() {
    // Determine asteroid size and points
    final size = _random.nextDouble() * 30 + 30; // 30-60
    final points = (size < 40) ? 30 : (size < 50) ? 20 : 10;
    
    // Determine spawn position (top of screen, random x)
    final x = _random.nextDouble() * (_screenSize.width - size);
    const y = -60.0; // Just above the screen
    
    // Determine velocity (random angle downward)
    final angle = _random.nextDouble() * 0.5 + 0.75; // 0.75-1.25 radians
    final vx = sin(angle) * (0.5 - _random.nextDouble()); // Random horizontal velocity
    final vy = cos(angle); // Downward velocity
    
    // Create asteroid
    final asteroid = AsteroidData(
      position: Offset(x, y),
      size: size,
      points: points,
      velocity: Offset(vx, vy),
      speed: 1.0 + _random.nextDouble() * _level, // Speed increases with level
      rotationSpeed: 0.5 + _random.nextDouble(),
    );
    
    _asteroids.add(asteroid);
  }
  
  // Update game state
  void _updateGame() {
    // Update lasers
    for (int i = _lasers.length - 1; i >= 0; i--) {
      final laser = _lasers[i];
      
      // Move laser
      laser.position = Offset(
        laser.position.dx + laser.velocity.dx * laser.speed,
        laser.position.dy + laser.velocity.dy * laser.speed,
      );
      
      // Remove if off screen
      if (laser.position.dy < -20) {
        _lasers.removeAt(i);
      }
    }
    
    // Update asteroids
    for (int i = _asteroids.length - 1; i >= 0; i--) {
      final asteroid = _asteroids[i];
      
      // Move asteroid
      asteroid.position = Offset(
        asteroid.position.dx + asteroid.velocity.dx * asteroid.speed,
        asteroid.position.dy + asteroid.velocity.dy * asteroid.speed,
      );
      
      // Check if asteroid is off screen
      if (asteroid.position.dy > _screenSize.height + asteroid.size) {
        _asteroids.removeAt(i);
        continue;
      }
      
      // Check for collision with player
      if (!asteroid.isHit && _checkPlayerCollision(asteroid)) {
        asteroid.isHit = true;
        _lives--;
        
        // Remove asteroid after hit animation
        Future.delayed(const Duration(milliseconds: 800), () {
          if (_asteroids.contains(asteroid)) {
            _asteroids.remove(asteroid);
          }
          notifyListeners();
        });
        
        // Check for game over
        if (_lives <= 0) {
          endGame();
        }
        
        continue;
      }
      
      // Check for collision with lasers
      for (int j = _lasers.length - 1; j >= 0; j--) {
        final laser = _lasers[j];
        
        if (!asteroid.isHit && _checkLaserCollision(laser, asteroid)) {
          // Mark asteroid as hit
          asteroid.isHit = true;
          
          // Add points
          _score += asteroid.points;
          
          // Remove laser
          _lasers.removeAt(j);
          
          // Remove asteroid after hit animation
          Future.delayed(const Duration(milliseconds: 800), () {
            if (_asteroids.contains(asteroid)) {
              _asteroids.remove(asteroid);
            }
            notifyListeners();
          });
          
          // Level up if score threshold reached
          if (_score >= _level * 100) {
            _level++;
            
            // Restart asteroid spawner with new rate
            _startAsteroidSpawner();
          }
          
          break;
        }
      }
    }
  }
  
  // Check for collision between player and asteroid
  bool _checkPlayerCollision(AsteroidData asteroid) {
    final playerRadius = 30.0;
    final distance = (_playerPosition - asteroid.position).distance;
    return distance < playerRadius + asteroid.size / 2;
  }
  
  // Check for collision between laser and asteroid
  bool _checkLaserCollision(LaserData laser, AsteroidData asteroid) {
    final laserRadius = 2.0;
    final distance = (laser.position - asteroid.position).distance;
    return distance < laserRadius + asteroid.size / 2;
  }
  
  // Stop all timers
  void _stopTimers() {
    _gameLoopTimer?.cancel();
    _asteroidSpawnTimer?.cancel();
  }
  
  // Load high score from shared preferences
  Future<void> _loadHighScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _highScore = prefs.getInt('space_shooter_high_score') ?? 0;
    } catch (e) {
      debugPrint('Error loading high score: $e');
    }
  }
  
  // Save high score to shared preferences
  Future<void> _saveHighScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('space_shooter_high_score', _highScore);
    } catch (e) {
      debugPrint('Error saving high score: $e');
    }
  }
  
  @override
  void dispose() {
    _stopTimers();
    super.dispose();
  }
}

class AsteroidData {
  Offset position;
  final double size;
  final int points;
  final Offset velocity;
  final double speed;
  final double rotationSpeed;
  bool isHit;
  
  AsteroidData({
    required this.position,
    required this.size,
    required this.points,
    required this.velocity,
    required this.speed,
    required this.rotationSpeed,
    this.isHit = false,
  });
}

class LaserData {
  Offset position;
  final Offset velocity;
  final double speed;
  
  LaserData({
    required this.position,
    required this.velocity,
    required this.speed,
  });
} 