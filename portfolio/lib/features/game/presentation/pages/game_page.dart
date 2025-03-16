import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/features/game/domain/controllers/game_controller.dart';
import 'package:portfolio/features/game/presentation/widgets/asteroid.dart';
import 'package:portfolio/features/game/presentation/widgets/game_hud.dart';
import 'package:portfolio/features/game/presentation/widgets/game_over_dialog.dart';
import 'package:portfolio/features/game/presentation/widgets/laser_beam.dart';
import 'package:portfolio/features/game/presentation/widgets/space_ship.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late GameController _gameController;
  final FocusNode _focusNode = FocusNode();
  
  // Movement control
  bool _isMovingUp = false;
  bool _isMovingDown = false;
  bool _isMovingLeft = false;
  bool _isMovingRight = false;
  
  // Animation controllers
  late AnimationController _starfieldController;
  late Animation<double> _starfieldAnimation;
  
  // Stars for background
  final List<Star> _stars = [];
  final Random _random = Random();
  
  @override
  void initState() {
    super.initState();
    
    // Initialize game controller
    _gameController = GameController();
    
    // Initialize starfield animation
    _starfieldController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    
    _starfieldAnimation = Tween<double>(
      begin: 0,
      end: 1000,
    ).animate(_starfieldController);
    
    _starfieldController.repeat();
    
    // Generate stars for background
    _generateStars(100);
    
    // Initialize game after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeGame();
    });
  }
  
  void _initializeGame() {
    final size = MediaQuery.of(context).size;
    _gameController.initialize(size);
    
    // Show start game dialog
    _showStartGameDialog();
  }
  
  void _generateStars(int count) {
    _stars.clear();
    for (int i = 0; i < count; i++) {
      _stars.add(Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 1 + _random.nextDouble() * 2,
        brightness: 0.3 + _random.nextDouble() * 0.7,
      ));
    }
  }
  
  void _showStartGameDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade800,
                Colors.blue.shade700,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
            border: Border.all(
              color: Colors.lightBlue.shade300,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SPACE SHOOTER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Controls:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Arrow Keys: Move\nSpace: Fire\nP: Pause',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _gameController.startGame();
                      _focusNode.requestFocus();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(AppConstants.homeRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _isMovingUp = true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _isMovingDown = true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _isMovingLeft = true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _isMovingRight = true;
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        _gameController.fireLaser();
      } else if (event.logicalKey == LogicalKeyboardKey.keyP) {
        _gameController.togglePause();
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _isMovingUp = false;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _isMovingDown = false;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _isMovingLeft = false;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _isMovingRight = false;
      }
    }
    
    // Calculate movement direction
    double dx = 0;
    double dy = 0;
    
    if (_isMovingLeft) dx -= 1;
    if (_isMovingRight) dx += 1;
    if (_isMovingUp) dy -= 1;
    if (_isMovingDown) dy += 1;
    
    // Normalize diagonal movement
    if (dx != 0 && dy != 0) {
      dx *= 0.7071; // 1/sqrt(2)
      dy *= 0.7071;
    }
    
    _gameController.movePlayer(Offset(dx, dy));
  }
  
  @override
  void dispose() {
    _gameController.dispose();
    _starfieldController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _gameController,
      child: Scaffold(
        body: Column(
          children: [
            const CustomNavigationBar(currentRoute: AppConstants.gameRoute),
            Expanded(
              child: RawKeyboardListener(
                focusNode: _focusNode,
                onKey: _handleKeyEvent,
                child: GestureDetector(
                  onTap: () => _focusNode.requestFocus(),
                  child: Stack(
                    children: [
                      // Background
                      _buildStarfieldBackground(),
                      
                      // Game elements
                      Consumer<GameController>(
                        builder: (context, controller, child) {
                          return Stack(
                            children: [
                              // Lasers
                              ..._buildLasers(controller),
                              
                              // Player ship
                              _buildPlayerShip(controller),
                              
                              // Asteroids
                              ..._buildAsteroids(controller),
                              
                              // HUD
                              _buildHUD(controller),
                              
                              // Game over dialog
                              if (controller.isGameOver)
                                Center(
                                  child: GameOverDialog(
                                    finalScore: controller.score,
                                    highScore: controller.highScore,
                                    onRestart: () {
                                      controller.startGame();
                                      _focusNode.requestFocus();
                                    },
                                    onExit: () {
                                      context.go(AppConstants.homeRoute);
                                    },
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStarfieldBackground() {
    return AnimatedBuilder(
      animation: _starfieldAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: StarfieldPainter(
            stars: _stars,
            offset: _starfieldAnimation.value,
          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
  
  Widget _buildPlayerShip(GameController controller) {
    return Positioned(
      left: controller.playerPosition.dx - 30,
      top: controller.playerPosition.dy - 45,
      child: SpaceShip(
        isMoving: controller.isPlayerMoving,
        isFiring: controller.isPlayerFiring,
      ),
    );
  }
  
  List<Widget> _buildLasers(GameController controller) {
    return controller.lasers.map((laser) {
      return Positioned(
        left: laser.position.dx - 2,
        top: laser.position.dy - 10,
        child: const LaserBeam(
          width: 4,
          height: 20,
          color: Colors.lightBlue,
        ),
      );
    }).toList();
  }
  
  List<Widget> _buildAsteroids(GameController controller) {
    return controller.asteroids.map((asteroid) {
      return Positioned(
        left: asteroid.position.dx - asteroid.size / 2,
        top: asteroid.position.dy - asteroid.size / 2,
        child: Asteroid(
          size: asteroid.size,
          points: asteroid.points,
          isHit: asteroid.isHit,
          rotationSpeed: asteroid.rotationSpeed,
        ),
      );
    }).toList();
  }
  
  Widget _buildHUD(GameController controller) {
    return GameHUD(
      score: controller.score,
      lives: controller.lives,
      level: controller.level,
      isPaused: controller.isPaused,
      onPausePressed: () => controller.togglePause(),
      onResumePressed: () => controller.togglePause(),
    );
  }
}

class StarfieldPainter extends CustomPainter {
  final List<Star> stars;
  final double offset;
  
  StarfieldPainter({
    required this.stars,
    required this.offset,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    final backgroundPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black,
          Colors.blue.shade900.withOpacity(0.5),
          Colors.black,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );
    
    // Draw stars
    for (final star in stars) {
      final y = (star.y * size.height + offset) % size.height;
      
      final starPaint = Paint()
        ..color = Colors.white.withOpacity(star.brightness)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(
        Offset(star.x * size.width, y),
        star.size,
        starPaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant StarfieldPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double brightness;
  
  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.brightness,
  });
} 