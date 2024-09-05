import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:example/animation/animation_catlog.dart';
import 'package:example/page_transition/page_transition_animations.dart';
import 'package:example/utility/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AnimationsScreen(),
    );
  }
}

class AnimationsScreen extends StatelessWidget {
  const AnimationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.magenta,
        title: const Text("Animation Widget Example"),
      ),
      body: const Center(
        child: AnimationsColumn(),
      ),
    );
  }
}

class AnimationsColumn extends StatelessWidget {
  const AnimationsColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        AnimatedButton(
          text: 'Page Transition Animations',
          targetPage: PageTransitionAnimationWidget(),
          animationDirection: Direction.down,
        ),
        AnimatedButton(
          text: 'Animations',
          targetPage: AnimationCatlog(),
          animationDirection: Direction.up,
        ),
      ],
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final String text;
  final Widget targetPage;
  final Direction animationDirection;

  const AnimatedButton({
    Key? key,
    required this.text,
    required this.targetPage,
    required this.animationDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInAnimation(
      direction: animationDirection,
      duration: const Duration(seconds: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta,
        ),
        onPressed: () => _navigateToPage(context),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context) {
    Navigator.push(
      context,
      ScaleSlideTransition(
        page: targetPage,
        isLeftScaled: false,
      ),
    );
  }
}