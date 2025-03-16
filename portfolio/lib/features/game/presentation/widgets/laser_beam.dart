import 'package:flutter/material.dart';

class LaserBeam extends StatefulWidget {
  final double width;
  final double height;
  final Color color;
  
  const LaserBeam({
    Key? key,
    this.width = 4.0,
    this.height = 20.0,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  State<LaserBeam> createState() => _LaserBeamState();
}

class _LaserBeamState extends State<LaserBeam> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _controller.repeat(reverse: true);
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
        return Container(
          width: widget.width * _pulseAnimation.value,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.width / 2),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.7),
                blurRadius: 5.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class LaserBeamPainter extends CustomPainter {
  final Color color;
  
  LaserBeamPainter({
    this.color = Colors.blue,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final glowPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    
    // Draw the beam
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(size.width / 2));
    
    // Draw glow effect
    canvas.drawRRect(rRect, glowPaint);
    
    // Draw main beam
    canvas.drawRRect(rRect, paint);
  }
  
  @override
  bool shouldRepaint(covariant LaserBeamPainter oldDelegate) {
    return oldDelegate.color != color;
  }
} 