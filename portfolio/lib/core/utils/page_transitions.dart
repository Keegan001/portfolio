import 'package:flutter/material.dart';

class FadeTransitionPage extends Page {
  final Widget child;
  final Duration duration;

  const FadeTransitionPage({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

class SlideTransitionPage extends Page {
  final Widget child;
  final Duration duration;
  final AxisDirection direction;

  const SlideTransitionPage({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.direction = AxisDirection.right,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin;
        
        switch (direction) {
          case AxisDirection.up:
            begin = const Offset(0.0, 1.0);
            break;
          case AxisDirection.down:
            begin = const Offset(0.0, -1.0);
            break;
          case AxisDirection.right:
            begin = const Offset(-1.0, 0.0);
            break;
          case AxisDirection.left:
            begin = const Offset(1.0, 0.0);
            break;
        }
        
        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
    );
  }
}

class ScaleTransitionPage extends Page {
  final Widget child;
  final Duration duration;
  final Alignment alignment;

  const ScaleTransitionPage({
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.alignment = Alignment.center,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
          alignment: alignment,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
} 