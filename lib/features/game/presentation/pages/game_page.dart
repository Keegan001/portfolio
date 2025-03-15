import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/responsive_utils.dart';
import 'package:portfolio/core/widgets/animated_button.dart';
import 'package:portfolio/core/widgets/footer.dart';
import 'package:portfolio/core/widgets/navigation_bar.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final List<IconData> _icons = [
    Icons.flutter_dash,
    FontAwesomeIcons.code,
    FontAwesomeIcons.fire,
    FontAwesomeIcons.android,
    FontAwesomeIcons.apple,
    FontAwesomeIcons.chrome,
    FontAwesomeIcons.codeBranch,
    FontAwesomeIcons.github,
  ];
  
  late List<IconData> _cards;
  List<int> _flippedCards = [];
  List<int> _matchedCards = [];
  int _score = 0;
  int _moves = 0;
  bool _isGameStarted = false;
  bool _isGameOver = false;
  late Timer _timer;
  int _timeLeft = 60;

  @override
  void dispose() {
    if (_isGameStarted) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _cards = [..._icons, ..._icons];
      _cards.shuffle(Random());
      _flippedCards = [];
      _matchedCards = [];
      _score = 0;
      _moves = 0;
      _isGameStarted = true;
      _isGameOver = false;
      _timeLeft = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _endGame();
        }
      });
    });
  }

  void _endGame() {
    _timer.cancel();
    setState(() {
      _isGameStarted = false;
      _isGameOver = true;
    });
  }

  void _onCardTap(int index) {
    if (!_isGameStarted || _isGameOver || _flippedCards.length >= 2 || _matchedCards.contains(index) || _flippedCards.contains(index)) {
      return;
    }

    setState(() {
      _flippedCards.add(index);
    });

    if (_flippedCards.length == 2) {
      _moves++;
      if (_cards[_flippedCards[0]] == _cards[_flippedCards[1]]) {
        // Match found
        _score += 10;
        _matchedCards.addAll(_flippedCards);
        
        if (_matchedCards.length == _cards.length) {
          // All cards matched, game over
          _endGame();
        }
        
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _flippedCards = [];
            });
          }
        });
      } else {
        // No match
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _flippedCards = [];
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomNavigationBar(currentRoute: AppConstants.gameRoute),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context),
                    _buildGameSection(context),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            'Memory Card Game',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 40),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: ResponsiveUtils.isMobile(context) ? double.infinity : 600,
            child: Text(
              'Test your memory with this fun card matching game! Find all the matching pairs before the time runs out.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getFontSize(context, 16),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameSection(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return Container(
      padding: ResponsiveUtils.getScreenPadding(context).copyWith(
        top: 60,
        bottom: 60,
      ),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          _buildGameControls(context),
          const SizedBox(height: 40),
          if (_isGameStarted || _isGameOver)
            _buildGameGrid(context, isMobile)
          else
            _buildGameIntro(context),
        ],
      ),
    );
  }

  Widget _buildGameControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildGameStat(context, 'Score', _score.toString()),
          _buildGameStat(context, 'Moves', _moves.toString()),
          _buildGameStat(context, 'Time', _timeLeft.toString()),
          if (!_isGameStarted)
            AnimatedButton(
              text: _isGameOver ? 'Play Again' : 'Start Game',
              icon: Icons.play_arrow,
              onPressed: _startGame,
            ),
        ],
      ),
    );
  }

  Widget _buildGameStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildGameGrid(BuildContext context, bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 4 : 8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: _cards.length,
      itemBuilder: (context, index) {
        final isFlipped = _flippedCards.contains(index) || _matchedCards.contains(index);
        final isMatched = _matchedCards.contains(index);
        
        return MemoryCardIcon(
          icon: _cards[index],
          isFlipped: isFlipped,
          isMatched: isMatched,
          onTap: () => _onCardTap(index),
        );
      },
    );
  }

  Widget _buildGameIntro(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.extension,
          size: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          _isGameOver
              ? 'Game Over! Your final score is $_score.'
              : 'Click the Start Game button to begin!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Match pairs of cards to earn points. You have 60 seconds to find all matches.',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class MemoryCardIcon extends StatefulWidget {
  final IconData icon;
  final bool isFlipped;
  final bool isMatched;
  final VoidCallback onTap;

  const MemoryCardIcon({
    Key? key,
    required this.icon,
    required this.isFlipped,
    required this.isMatched,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MemoryCardIcon> createState() => _MemoryCardIconState();
}

class _MemoryCardIconState extends State<MemoryCardIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFrontVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: pi / 2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: pi / 2, end: pi)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _animation.addListener(() {
      if (_animation.value > pi / 2 && !_isFrontVisible) {
        setState(() {
          _isFrontVisible = true;
        });
      } else if (_animation.value < pi / 2 && _isFrontVisible) {
        setState(() {
          _isFrontVisible = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(MemoryCardIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_animation.value);
          
          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: _isFrontVisible ? _buildFrontCard() : _buildBackCard(),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      decoration: BoxDecoration(
        color: widget.isMatched 
            ? Colors.green.withOpacity(0.2) 
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: widget.isMatched 
              ? Colors.green 
              : Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          widget.icon,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Transform(
      transform: Matrix4.identity()..rotateY(pi),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.question_mark,
            size: 40,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
} 