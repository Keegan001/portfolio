import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum AnimationType {
  fadeIn,
  slideUp,
  slideLeft,
  slideRight,
  scale,
  custom
}

class ScrollAnimation extends StatefulWidget {
  final Widget child;
  final AnimationType animationType;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Animation<double>? customAnimation;
  final bool once;

  const ScrollAnimation({
    Key? key,
    required this.child,
    this.animationType = AnimationType.fadeIn,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.customAnimation,
    this.once = true,
  }) : super(key: key);

  @override
  State<ScrollAnimation> createState() => _ScrollAnimationState();
}

class _ScrollAnimationState extends State<ScrollAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = false;
  bool _hasAnimated = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = widget.customAnimation ?? Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (!mounted) return;
    
    final RenderObject? renderObject = _key.currentContext?.findRenderObject();
    if (renderObject == null) return;
    
    final RenderBox box = renderObject as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final size = box.size;
    
    final screenHeight = MediaQuery.of(context).size.height;
    final visible = position.dy < screenHeight && position.dy + size.height > 0;
    
    if (visible && (!_hasAnimated || !widget.once)) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
        
        Future.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward().then((_) {
              _hasAnimated = true;
            });
          }
        });
      }
    } else if (!visible && !widget.once && _isVisible) {
      setState(() {
        _isVisible = false;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add a listener to the scroll notification
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkVisibility();
        return false;
      },
      child: AnimatedBuilder(
        key: _key,
        animation: _animation,
        builder: (context, child) {
          switch (widget.animationType) {
            case AnimationType.fadeIn:
              return Opacity(
                opacity: _animation.value,
                child: child,
              );
            case AnimationType.slideUp:
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _animation.value)),
                child: Opacity(
                  opacity: _animation.value,
                  child: child,
                ),
              );
            case AnimationType.slideLeft:
              return Transform.translate(
                offset: Offset(50 * (1 - _animation.value), 0),
                child: Opacity(
                  opacity: _animation.value,
                  child: child,
                ),
              );
            case AnimationType.slideRight:
              return Transform.translate(
                offset: Offset(-50 * (1 - _animation.value), 0),
                child: Opacity(
                  opacity: _animation.value,
                  child: child,
                ),
              );
            case AnimationType.scale:
              return Transform.scale(
                scale: 0.8 + (0.2 * _animation.value),
                child: Opacity(
                  opacity: _animation.value,
                  child: child,
                ),
              );
            case AnimationType.custom:
              return widget.child;
            default:
              return child!;
          }
        },
        child: widget.child,
      ),
    );
  }
} 