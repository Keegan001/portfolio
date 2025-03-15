import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool enableRotation;
  final bool enableScale;
  final bool enableShadow;

  const AnimatedCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.padding,
    this.onTap,
    this.enableRotation = true,
    this.enableScale = true,
    this.enableShadow = true,
  }) : super(key: key);

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  double _rotateX = 0;
  double _rotateY = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
      _rotateX = 0;
      _rotateY = 0;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.enableRotation || !_isHovered) return;
    
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Size size = box.size;
    final Offset position = box.globalToLocal(details.globalPosition);
    
    setState(() {
      _rotateY = (position.dx / size.width - 0.5) * 0.2;
      _rotateX = (position.dy / size.height - 0.5) * -0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = widget.color ?? theme.cardTheme.color ?? theme.colorScheme.surface;
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(16);
    
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      onHover: (event) {
        if (!widget.enableRotation || !_isHovered) return;
        _onPanUpdate(DragUpdateDetails(
          globalPosition: event.position,
          delta: Offset.zero,
        ));
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_rotateX)
                ..rotateY(_rotateY)
                ..scale(widget.enableScale ? _scaleAnimation.value : 1.0),
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: widget.padding ?? const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: borderRadius,
                  boxShadow: widget.enableShadow && _isHovered
                      ? [
                          BoxShadow(
                            color: theme.shadowColor.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : null,
                ),
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
} 