import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpaceShip extends StatefulWidget {
  final double size;
  final bool isMoving;
  final bool isFiring;
  
  const SpaceShip({
    Key? key,
    this.size = 60.0,
    this.isMoving = false,
    this.isFiring = false,
  }) : super(key: key);

  @override
  State<SpaceShip> createState() => _SpaceShipState();
}

class _SpaceShipState extends State<SpaceShip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flameAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    
    _flameAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size * 1.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main ship body
          CustomPaint(
            size: Size(widget.size, widget.size * 1.5),
            painter: SpaceShipPainter(
              isMoving: widget.isMoving,
              isFiring: widget.isFiring,
            ),
          ),
          
          // Engine flame when moving
          if (widget.isMoving)
            Positioned(
              bottom: 0,
              child: AnimatedBuilder(
                animation: _flameAnimation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer flame glow
                      Container(
                        width: widget.size * 0.5 * _flameAnimation.value,
                        height: widget.size * 0.8 * _flameAnimation.value,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topCenter,
                            radius: 0.8,
                            colors: [
                              Colors.orange.shade300.withOpacity(0.3),
                              Colors.orange.shade500.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(widget.size * 0.25),
                        ),
                      ),
                      
                      // Main flame
                      Container(
                        width: widget.size * 0.4,
                        height: widget.size * (0.6 + 0.2 * math.sin(_controller.value * math.pi)),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.orange.shade600,
                              Colors.orange.shade300,
                              Colors.yellow.shade300,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(widget.size * 0.2),
                            bottomRight: Radius.circular(widget.size * 0.2),
                            topLeft: Radius.circular(widget.size * 0.05),
                            topRight: Radius.circular(widget.size * 0.05),
                          ),
                        ),
                      ),
                      
                      // Inner flame
                      Container(
                        width: widget.size * 0.25,
                        height: widget.size * (0.4 + 0.15 * math.cos(_controller.value * math.pi * 2)),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.yellow.shade200,
                              Colors.yellow.shade400,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(widget.size * 0.15),
                            bottomRight: Radius.circular(widget.size * 0.15),
                            topLeft: Radius.circular(widget.size * 0.05),
                            topRight: Radius.circular(widget.size * 0.05),
                          ),
                        ),
                      ),
                      
                      // Flame particles
                      ...List.generate(5, (index) {
                        final random = math.Random(index);
                        final offset = random.nextDouble() * 0.4 - 0.2;
                        final size = random.nextDouble() * 0.1 + 0.05;
                        final animValue = ((_controller.value + index * 0.2) % 1.0);
                        
                        return Positioned(
                          bottom: widget.size * 0.7 * animValue,
                          left: widget.size * (0.5 + offset - size/2),
                          child: Opacity(
                            opacity: 1.0 - animValue,
                            child: Container(
                              width: widget.size * size,
                              height: widget.size * size,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade300,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          
          // Weapon fire when firing
          if (widget.isFiring)
            Positioned(
              top: -widget.size * 0.3,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: widget.size * 0.2,
                height: widget.size * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade200,
                      Colors.lightBlue.shade100,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(widget.size * 0.1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SpaceShipPainter extends CustomPainter {
  final bool isMoving;
  final bool isFiring;
  
  SpaceShipPainter({
    this.isMoving = false,
    this.isFiring = false,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    
    // Define colors
    final mainColor = isFiring ? Colors.blue.shade700 : Colors.blue.shade600;
    final accentColor = Colors.lightBlue.shade300;
    final windowColor = Colors.lightBlue.shade100;
    
    // Create paint objects
    final mainPaint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill;
    
    final accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
    
    final windowPaint = Paint()
      ..color = windowColor
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    // Draw ship body
    final bodyPath = Path()
      ..moveTo(width * 0.2, height * 0.8)
      ..lineTo(width * 0.2, height * 0.3)
      ..quadraticBezierTo(width * 0.5, height * 0.1, width * 0.8, height * 0.3)
      ..lineTo(width * 0.8, height * 0.8)
      ..close();
    
    canvas.drawPath(bodyPath, mainPaint);
    canvas.drawPath(bodyPath, borderPaint);
    
    // Draw wings
    final leftWingPath = Path()
      ..moveTo(width * 0.2, height * 0.5)
      ..lineTo(0, height * 0.7)
      ..lineTo(width * 0.2, height * 0.7)
      ..close();
    
    final rightWingPath = Path()
      ..moveTo(width * 0.8, height * 0.5)
      ..lineTo(width, height * 0.7)
      ..lineTo(width * 0.8, height * 0.7)
      ..close();
    
    canvas.drawPath(leftWingPath, accentPaint);
    canvas.drawPath(leftWingPath, borderPaint);
    canvas.drawPath(rightWingPath, accentPaint);
    canvas.drawPath(rightWingPath, borderPaint);
    
    // Draw cockpit window
    final windowPath = Path()
      ..moveTo(width * 0.4, height * 0.3)
      ..quadraticBezierTo(width * 0.5, height * 0.2, width * 0.6, height * 0.3)
      ..lineTo(width * 0.6, height * 0.4)
      ..quadraticBezierTo(width * 0.5, height * 0.45, width * 0.4, height * 0.4)
      ..close();
    
    canvas.drawPath(windowPath, windowPaint);
    canvas.drawPath(windowPath, borderPaint);
    
    // Draw engine
    final engineRect = Rect.fromLTWH(
      width * 0.3,
      height * 0.8,
      width * 0.4,
      height * 0.1,
    );
    
    canvas.drawRect(engineRect, accentPaint);
    canvas.drawRect(engineRect, borderPaint);
    
    // Draw details
    if (isFiring) {
      // Weapon glow
      final weaponGlowPaint = Paint()
        ..color = Colors.blue.shade200.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      
      canvas.drawCircle(
        Offset(width * 0.5, height * 0.15),
        width * 0.2,
        weaponGlowPaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant SpaceShipPainter oldDelegate) {
    return oldDelegate.isMoving != isMoving || 
           oldDelegate.isFiring != isFiring;
  }
} 