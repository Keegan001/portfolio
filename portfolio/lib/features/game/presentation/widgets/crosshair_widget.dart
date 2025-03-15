import 'package:flutter/material.dart';
import 'dart:math' as math;

class CrosshairWidget extends StatefulWidget {
  final Color color;
  final double size;
  final double thickness;
  final bool isAiming;
  final bool isShooting;

  const CrosshairWidget({
    Key? key,
    this.color = Colors.white,
    this.size = 20.0,
    this.thickness = 2.0,
    this.isAiming = false,
    this.isShooting = false,
  }) : super(key: key);

  @override
  State<CrosshairWidget> createState() => _CrosshairWidgetState();
}

class _CrosshairWidgetState extends State<CrosshairWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }
  
  @override
  void didUpdateWidget(CrosshairWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (!oldWidget.isShooting && widget.isShooting) {
      _controller.forward(from: 0.0);
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
        return SizedBox(
          width: widget.size * _pulseAnimation.value,
          height: widget.size * _pulseAnimation.value,
          child: CustomPaint(
            painter: EnhancedCrosshairPainter(
              color: widget.isShooting 
                  ? const Color(0xFF87CEEB) // Light sky blue
                  : widget.isAiming 
                      ? const Color(0xFF4682B4) // Steel blue
                      : widget.color,
              thickness: widget.thickness,
              isAiming: widget.isAiming,
              animationValue: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

class EnhancedCrosshairPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final bool isAiming;
  final double animationValue;

  EnhancedCrosshairPainter({
    required this.color,
    required this.thickness,
    required this.isAiming,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Dynamic gap based on aiming state
    final gap = isAiming ? radius * 0.15 : radius * 0.3;
    
    // Draw horizontal line
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx - gap, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + gap, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );

    // Draw vertical line
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy - gap),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy + gap),
      Offset(center.dx, center.dy + radius),
      paint,
    );

    // Draw center dot with animation
    final dotSize = isAiming ? thickness * 0.75 : thickness / 2;
    canvas.drawCircle(
      center,
      dotSize * (1.0 - animationValue * 0.5),
      paint,
    );

    // Draw outer circle with animation
    paint.style = PaintingStyle.stroke;
    
    // Draw animated targeting circles when aiming
    if (isAiming) {
      // Draw multiple circles with different opacities
      for (int i = 0; i < 3; i++) {
        final circleRadius = radius * 0.8 - (i * thickness * 2);
        final opacity = 1.0 - (i * 0.25);
        
        paint.color = color.withOpacity(opacity);
        canvas.drawCircle(
          center,
          circleRadius,
          paint,
        );
      }
      
      // Draw diagonal lines for enhanced targeting
      paint.color = color.withOpacity(0.7);
      final diagonalLength = radius * 0.3;
      
      // Top-left diagonal
      canvas.drawLine(
        Offset(center.dx - diagonalLength, center.dy - diagonalLength),
        Offset(center.dx - diagonalLength * 0.5, center.dy - diagonalLength * 0.5),
        paint,
      );
      
      // Top-right diagonal
      canvas.drawLine(
        Offset(center.dx + diagonalLength, center.dy - diagonalLength),
        Offset(center.dx + diagonalLength * 0.5, center.dy - diagonalLength * 0.5),
        paint,
      );
      
      // Bottom-left diagonal
      canvas.drawLine(
        Offset(center.dx - diagonalLength, center.dy + diagonalLength),
        Offset(center.dx - diagonalLength * 0.5, center.dy + diagonalLength * 0.5),
        paint,
      );
      
      // Bottom-right diagonal
      canvas.drawLine(
        Offset(center.dx + diagonalLength, center.dy + diagonalLength),
        Offset(center.dx + diagonalLength * 0.5, center.dy + diagonalLength * 0.5),
        paint,
      );
    } else {
      // Standard circle for normal state
      canvas.drawCircle(
        center,
        radius * 0.8 * (1.0 + animationValue * 0.2),
        paint,
      );
    }
    
    // Draw shooting effect
    if (animationValue > 0) {
      final shootPaint = Paint()
        ..color = color.withOpacity(0.3 * (1.0 - animationValue))
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness * 0.5;
      
      canvas.drawCircle(
        center,
        radius * (0.5 + animationValue * 1.0),
        shootPaint,
      );
    }
  }

  @override
  bool shouldRepaint(EnhancedCrosshairPainter oldDelegate) {
    return oldDelegate.color != color || 
           oldDelegate.thickness != thickness ||
           oldDelegate.isAiming != isAiming ||
           oldDelegate.animationValue != animationValue;
  }
} 