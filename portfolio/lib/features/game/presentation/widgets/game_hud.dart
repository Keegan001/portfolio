import 'package:flutter/material.dart';

class GameHUD extends StatelessWidget {
  final int score;
  final int lives;
  final int level;
  final bool isPaused;
  final VoidCallback? onPausePressed;
  final VoidCallback? onResumePressed;
  
  const GameHUD({
    Key? key,
    required this.score,
    required this.lives,
    required this.level,
    this.isPaused = false,
    this.onPausePressed,
    this.onResumePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScoreDisplay(context),
              _buildPauseButton(context),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLivesDisplay(context),
              _buildLevelDisplay(context),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildScoreDisplay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.lightBlue.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Score: $score',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLivesDisplay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.redAccent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.redAccent,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Lives: $lives',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLevelDisplay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.purpleAccent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.trending_up,
            color: Colors.purpleAccent,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Level: $level',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPauseButton(BuildContext context) {
    return GestureDetector(
      onTap: isPaused ? onResumePressed : onPausePressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.lightBlue.shade300,
            width: 2,
          ),
        ),
        child: Icon(
          isPaused ? Icons.play_arrow : Icons.pause,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
} 