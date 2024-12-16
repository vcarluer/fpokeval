```dart
import 'package:flutter/material.dart';
import 'package:pokeval/theme/app_theme.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Text(
              'Pokeval',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Positioned(
              top: -8,
              right: -8,
              child: SparkleAnimation(),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Stack(
            children: [
              const Text(
                'Quick Pokemon Card Value Checker',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Transform.rotate(
                  angle: -0.05,
                  child: Container(
                    height: 8,
                    color: Colors.yellow[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SparkleAnimation extends StatefulWidget {
  const SparkleAnimation({super.key});

  @override
  State<SparkleAnimation> createState() => _SparkleAnimationState();
}

class _SparkleAnimationState extends State<SparkleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        'assets/images/sparkle.png',
        width: 24,
        height: 24,
      ),
    );
  }
}
```