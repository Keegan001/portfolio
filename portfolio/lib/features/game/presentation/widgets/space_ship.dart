import 'package:flutter/material.dart';

class SpaceShip extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main ship body
          CustomPaint(
            size: Size(size, size * 1.5),
            painter: SpaceShipPainter(
              isMoving: isMoving,
              isFiring: isFiring,
            ),
          ),
          
          // Engine flame when moving
          if (isMoving)
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: size * 0.4,
                height: isMoving ? size * 0.6 : 0,
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
                  borderRadius: BorderRadius.circular(size * 0.2),
                ),
              ),
            ),
          
          // Weapon fire when firing
          if (isFiring)
            Positioned(
              top: -size * 0.3,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: size * 0.2,
                height: size * 0.5,
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
                  borderRadius: BorderRadius.circular(size * 0.1),
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