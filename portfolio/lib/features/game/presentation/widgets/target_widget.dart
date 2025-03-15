import 'package:flutter/material.dart';
import 'dart:math' as math;

class TargetWidget extends StatefulWidget {
  final double size;
  final bool isHit;
  final VoidCallback? onHit;
  final int points;
  final bool isMoving;
  final double speed;
  
  const TargetWidget({
    Key? key,
    required this.size,
    this.isHit = false,
    this.onHit,
    required this.points,
    this.isMoving = false,
    this.speed = 1.0,
  }) : super(key: key);
  
  @override
  State<TargetWidget> createState() => _TargetWidgetState();
}

class _TargetWidgetState extends State<TargetWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _hitAnimation;
  
  bool _isHovering = false;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _hitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );
    
    _controller.repeat(reverse: true);
  }
  
  @override
  void didUpdateWidget(TargetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (!oldWidget.isHit && widget.isHit) {
      _controller.stop();
      _controller.value = 0;
      _controller.forward();
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: widget.isHit ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isHit ? null : widget.onHit,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: widget.isHit ? 0 : _rotateAnimation.value,
              child: Transform.scale(
                scale: widget.isHit 
                    ? _hitAnimation.value 
                    : _isHovering 
                        ? 1.1 * _pulseAnimation.value 
                        : _pulseAnimation.value,
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: TargetPainter(
                    isHit: widget.isHit,
                    animationValue: _controller.value,
                    points: widget.points,
                    isHovering: _isHovering,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TargetPainter extends CustomPainter {
  final bool isHit;
  final double animationValue;
  final int points;
  final bool isHovering;
  
  TargetPainter({
    required this.isHit,
    required this.animationValue,
    required this.points,
    this.isHovering = false,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Define colors based on points
    Color primaryColor;
    Color secondaryColor;
    
    if (points >= 30) {
      // High value target (blue)
      primaryColor = const Color(0xFF64B5F6); // Light blue
      secondaryColor = const Color(0xFF1976D2); // Dark blue
    } else if (points >= 20) {
      // Medium value target (teal)
      primaryColor = const Color(0xFF4DD0E1); // Light teal
      secondaryColor = const Color(0xFF0097A7); // Dark teal
    } else {
      // Low value target (cyan)
      primaryColor = const Color(0xFF80DEEA); // Light cyan
      secondaryColor = const Color(0xFF00ACC1); // Dark cyan
    }
    
    // Colors for hit state
    final hitPrimaryColor = Colors.grey.shade400;
    final hitSecondaryColor = Colors.grey.shade700;
    
    // Add glow effect when hovering
    if (isHovering && !isHit) {
      final glowPaint = Paint()
        ..color = primaryColor.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      
      canvas.drawCircle(center, radius * 1.1, glowPaint);
    }
    
    // Draw target rings
    _drawTargetRings(
      canvas, 
      center, 
      radius, 
      isHit ? hitPrimaryColor : primaryColor, 
      isHit ? hitSecondaryColor : secondaryColor,
    );
    
    // Draw hit effect
    if (isHit) {
      _drawHitEffect(canvas, center, radius, animationValue);
    }
    
    // Draw points value
    _drawPointsValue(canvas, center, radius, points);
  }
  
  void _drawTargetRings(Canvas canvas, Offset center, double radius, Color primaryColor, Color secondaryColor) {
    // Outer ring
    final outerRingPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius, outerRingPaint);
    
    // Outer ring border
    final outerBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawCircle(center, radius, outerBorderPaint);
    
    // Middle ring
    final middleRingPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.7, middleRingPaint);
    
    // Middle ring border
    final middleBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    canvas.drawCircle(center, radius * 0.7, middleBorderPaint);
    
    // Inner ring
    final innerRingPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.4, innerRingPaint);
    
    // Inner ring border
    final innerBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    canvas.drawCircle(center, radius * 0.4, innerBorderPaint);
    
    // Bullseye
    final bullseyePaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.15, bullseyePaint);
    
    // Bullseye border
    final bullseyeBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    canvas.drawCircle(center, radius * 0.15, bullseyeBorderPaint);
    
    // Add shine effect
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    
    final shineRect = Rect.fromCenter(
      center: Offset(center.dx - radius * 0.3, center.dy - radius * 0.3),
      width: radius * 0.4,
      height: radius * 0.2,
    );
    
    canvas.drawOval(shineRect, shinePaint);
  }
  
  void _drawHitEffect(Canvas canvas, Offset center, double radius, double animationValue) {
    // Draw bullet hole
    final bulletHolePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.1, bulletHolePaint);
    
    // Draw cracks
    final crackPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final random = math.Random(42); // Fixed seed for consistent cracks
    
    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * math.pi;
      final length = radius * (0.2 + random.nextDouble() * 0.6);
      final startRadius = radius * 0.1;
      
      final start = Offset(
        center.dx + math.cos(angle) * startRadius,
        center.dy + math.sin(angle) * startRadius,
      );
      
      final end = Offset(
        center.dx + math.cos(angle) * length,
        center.dy + math.sin(angle) * length,
      );
      
      final controlPoint1 = Offset(
        center.dx + math.cos(angle + 0.2) * (length * 0.3),
        center.dy + math.sin(angle + 0.2) * (length * 0.3),
      );
      
      final controlPoint2 = Offset(
        center.dx + math.cos(angle - 0.2) * (length * 0.6),
        center.dy + math.sin(angle - 0.2) * (length * 0.6),
      );
      
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(
          controlPoint1.dx, controlPoint1.dy,
          controlPoint2.dx, controlPoint2.dy,
          end.dx, end.dy,
        );
      
      canvas.drawPath(path, crackPaint);
    }
    
    // Draw hit flash
    if (animationValue < 0.3) {
      final flashPaint = Paint()
        ..color = Colors.white.withOpacity(0.7 * (1 - animationValue / 0.3))
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(center, radius * (0.2 + animationValue), flashPaint);
    }
  }
  
  void _drawPointsValue(Canvas canvas, Offset center, double radius, int points) {
    final textStyle = TextStyle(
      color: isHit ? Colors.white.withOpacity(0.5) : Colors.white,
      fontSize: radius * 0.4,
      fontWeight: FontWeight.bold,
      shadows: const [
        Shadow(
          color: Colors.black26,
          offset: Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    );
    
    final textSpan = TextSpan(
      text: '+$points',
      style: textStyle,
    );
    
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    
    textPainter.layout();
    
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    
    textPainter.paint(canvas, textOffset);
  }
  
  @override
  bool shouldRepaint(TargetPainter oldDelegate) {
    return oldDelegate.isHit != isHit || 
           oldDelegate.animationValue != animationValue ||
           oldDelegate.points != points ||
           oldDelegate.isHovering != isHovering;
  }
} 