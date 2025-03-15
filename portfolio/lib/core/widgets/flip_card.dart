import 'dart:math';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final Widget frontWidget;
  final Widget backWidget;
  final Duration duration;
  final VoidCallback? onTap;
  final bool flipOnHover;
  final double height;
  final double width;
  final BoxDecoration? decoration;

  const FlipCard({
    Key? key,
    required this.frontWidget,
    required this.backWidget,
    this.duration = const Duration(milliseconds: 800),
    this.onTap,
    this.flipOnHover = true,
    this.height = 300,
    this.width = double.infinity,
    this.decoration,
  }) : super(key: key);

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (widget.flipOnHover) {
          setState(() {
            _isHovered = true;
          });
          _flip();
        }
      },
      onExit: (_) {
        if (widget.flipOnHover) {
          setState(() {
            _isHovered = false;
          });
          _flip();
        }
      },
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          } else if (!widget.flipOnHover) {
            _flip();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0, 0.0)
            ..scale(_isHovered ? 1.03 : 1.0),
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final angle = _animation.value * pi;
                final transform = Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateY(angle);
                
                return Transform(
                  transform: transform,
                  alignment: Alignment.center,
                  child: angle < pi / 2
                      ? _buildSide(widget.frontWidget, widget.decoration)
                      : Transform(
                          transform: Matrix4.identity()..rotateY(pi),
                          alignment: Alignment.center,
                          child: _buildSide(widget.backWidget, widget.decoration),
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSide(Widget content, BoxDecoration? decoration) {
    return Container(
      decoration: decoration ?? BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
} 