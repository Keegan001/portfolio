import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ParallaxContainer extends StatefulWidget {
  final Widget child;
  final double parallaxOffset;
  final Axis direction;
  final bool reverse;

  const ParallaxContainer({
    Key? key,
    required this.child,
    this.parallaxOffset = 100.0,
    this.direction = Axis.vertical,
    this.reverse = false,
  }) : super(key: key);

  @override
  State<ParallaxContainer> createState() => _ParallaxContainerState();
}

class _ParallaxContainerState extends State<ParallaxContainer> {
  final GlobalKey _containerKey = GlobalKey();
  double _scrollOffset = 0.0;
  double _containerPosition = 0.0;
  double _containerHeight = 0.0;
  double _containerWidth = 0.0;
  double _viewportHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateContainerDimensions();
    });
  }

  void _updateContainerDimensions() {
    final RenderBox? renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _containerHeight = renderBox.size.height;
        _containerWidth = renderBox.size.width;
        _containerPosition = renderBox.localToGlobal(Offset.zero).dy;
        _viewportHeight = MediaQuery.of(context).size.height;
      });
    }
  }

  void _updateScrollOffset() {
    final RenderBox? renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final newPosition = renderBox.localToGlobal(Offset.zero).dy;
      final scrollDelta = _containerPosition - newPosition;
      setState(() {
        _containerPosition = newPosition;
        _scrollOffset += scrollDelta;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _updateScrollOffset();
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the parallax effect
          final viewportHeight = MediaQuery.of(context).size.height;
          final viewportWidth = MediaQuery.of(context).size.width;
          
          // Calculate how far the container is from the center of the viewport
          final containerCenter = _containerPosition + _containerHeight / 2;
          final viewportCenter = viewportHeight / 2;
          final distanceFromCenter = containerCenter - viewportCenter;
          
          // Calculate the parallax offset based on the distance from center
          final parallaxFactor = distanceFromCenter / viewportHeight;
          final parallaxValue = widget.parallaxOffset * parallaxFactor * (widget.reverse ? -1 : 1);
          
          return Container(
            key: _containerKey,
            child: Transform.translate(
              offset: widget.direction == Axis.vertical
                  ? Offset(0, parallaxValue)
                  : Offset(parallaxValue, 0),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
} 