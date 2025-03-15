import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class ModelViewer extends StatefulWidget {
  final String modelPath;
  final Color backgroundColor;
  final bool autoRotate;
  final double rotationSpeed;
  final bool interactive;
  final double? width;
  final double? height;

  const ModelViewer({
    Key? key,
    required this.modelPath,
    this.backgroundColor = Colors.transparent,
    this.autoRotate = true,
    this.rotationSpeed = 0.01,
    this.interactive = true,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<ModelViewer> createState() => _ModelViewerState();
}

class _ModelViewerState extends State<ModelViewer> with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _model;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    scene.camera.position.z = 10;
    scene.light.position.setFrom(Vector3(0, 10, 10));
    scene.light.setColor(Colors.white, 1.0, 1.0);
    scene.world.add(Object(
      fileName: widget.modelPath,
      position: Vector3(0, 0, 0),
      scale: Vector3(1, 1, 1),
      lighting: true,
    ));
  }

  void _updateRotation() {
    if (widget.autoRotate && _model != null) {
      _model!.rotation.y += widget.rotationSpeed;
      _scene.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        if (widget.autoRotate) {
          _updateRotation();
        }
        return Container(
          width: widget.width,
          height: widget.height,
          color: widget.backgroundColor,
          child: Cube(
            onSceneCreated: _onSceneCreated,
            interactive: widget.interactive,
          ),
        );
      },
    );
  }
} 