import 'dart:math' as math;
import 'package:flutter/material.dart';

class Asteroid extends StatefulWidget {
  final double size;
  final int points;
  final bool isHit;
  final VoidCallback? onHit;
  final double rotationSpeed;
  
  const Asteroid({
    Key? key,
    this.size = 60.0,
    this.points = 10,
    this.isHit = false,
    this.onHit,
    this.rotationSpeed = 1.0,
  }) : super(key: key);

  @override
  State<Asteroid> createState() => _AsteroidState();
}

class _AsteroidState extends State<Asteroid> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi * widget.rotationSpeed,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    
    _controller.repeat();
    
    if (widget.isHit) {
      _controller.stop();
      _controller.reset();
      _controller.forward().then((_) {
        if (widget.onHit != null) {
          widget.onHit!();
        }
      });
    }
  }
  
  @override
  void didUpdateWidget(Asteroid oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isHit && !oldWidget.isHit) {
      _controller.stop();
      _controller.reset();
      _controller.forward().then((_) {
        if (widget.onHit != null) {
          widget.onHit!();
        }
      });
    }
    
    if (widget.rotationSpeed != oldWidget.rotationSpeed) {
      _rotationAnimation = Tween<double>(
        begin: _rotationAnimation.value,
        end: _rotationAnimation.value + 2 * math.pi * widget.rotationSpeed,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        ),
      );
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: widget.isHit ? _opacityAnimation.value : 1.0,
          child: Transform.scale(
            scale: widget.isHit ? _scaleAnimation.value : 1.0,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: CustomPaint(
                size: Size(widget.size, widget.size),
                painter: AsteroidPainter(
                  points: widget.points,
                  isHit: widget.isHit,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AsteroidPainter extends CustomPainter {
  final int points;
  final bool isHit;
  final math.Random random = math.Random(42); // Fixed seed for consistent shape
  
  AsteroidPainter({
    required this.points,
    this.isHit = false,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Determine color based on points
    Color asteroidColor;
    if (points >= 30) {
      asteroidColor = Colors.red.shade700; // High value asteroid
    } else if (points >= 20) {
      asteroidColor = Colors.orange.shade700; // Medium value asteroid
    } else {
      asteroidColor = Colors.grey.shade700; // Low value asteroid
    }
    
    // Create paint objects
    final fillPaint = Paint()
      ..color = isHit ? asteroidColor.withOpacity(0.5) : asteroidColor
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    // Create irregular asteroid shape
    final path = Path();
    
    // Number of vertices for the asteroid
    const vertexCount = 10;
    
    // Generate random points around a circle
    for (int i = 0; i < vertexCount; i++) {
      final angle = 2 * math.pi * i / vertexCount;
      // Vary the radius to create an irregular shape
      final vertexRadius = radius * (0.7 + 0.3 * random.nextDouble());
      final x = center.dx + vertexRadius * math.cos(angle);
      final y = center.dy + vertexRadius * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    path.close();
    
    // Draw the asteroid
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
    
    // Add craters
    final craterCount = 3 + random.nextInt(3);
    for (int i = 0; i < craterCount; i++) {
      final craterRadius = radius * (0.1 + 0.1 * random.nextDouble());
      final angle = 2 * math.pi * random.nextDouble();
      final distance = radius * 0.5 * random.nextDouble();
      final craterX = center.dx + distance * math.cos(angle);
      final craterY = center.dy + distance * math.sin(angle);
      
      final craterPaint = Paint()
        ..color = Colors.black38
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(
        Offset(craterX, craterY),
        craterRadius,
        craterPaint,
      );
    }
    
    // Add explosion effect if hit
    if (isHit) {
      final explosionPaint = Paint()
        ..color = Colors.orange.withOpacity(0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      
      canvas.drawCircle(
        center,
        radius * 1.2,
        explosionPaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant AsteroidPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.isHit != isHit;
  }
} 