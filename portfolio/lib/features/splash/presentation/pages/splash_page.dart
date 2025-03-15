import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/widgets/app_loading_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  String _loadingMessage = "Initializing...";
  double _progress = 0.0;
  
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }
  
  Future<void> _initializeApp() async {
    // Simulate loading different resources
    await Future.delayed(const Duration(milliseconds: 500));
    _updateLoadingState("Loading assets...", 0.2);
    
    await Future.delayed(const Duration(milliseconds: 800));
    _updateLoadingState("Preparing UI...", 0.5);
    
    await Future.delayed(const Duration(milliseconds: 700));
    _updateLoadingState("Almost there...", 0.8);
    
    await Future.delayed(const Duration(milliseconds: 500));
    _updateLoadingState("Ready!", 1.0);
    
    // Navigate to home page when loading is complete
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Delay navigation slightly to show the completed state
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          context.go('/home');
        }
      });
    }
  }
  
  void _updateLoadingState(String message, double progress) {
    if (mounted) {
      setState(() {
        _loadingMessage = message;
        _progress = progress;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLoadingScreen(
        message: _loadingMessage,
        progress: _progress,
      ),
    );
  }
} 