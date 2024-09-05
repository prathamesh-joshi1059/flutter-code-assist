import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:example/animation/animation_catlog.dart';
import 'package:example/page_transition/page_transition_animations.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  initializeData();
  runApp(const MyApp());
}

void initializeData() {
  debugPrint("Data initialized");
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
      body: const AnimationButtons(),
    );
  }
}

class AnimationButtons extends StatelessWidget {
  const AnimationButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AnimatedButton(
            text: 'Page Transition Animations',
            destination: PageTransitionAnimationWidget(),
            direction: Direction.down,
          ),
          AnimatedButton(
            text: 'Animations',
            destination: AnimationCatlog(),
            direction: Direction.up,
          ),
        ],
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final String text;
  final Widget destination;
  final Direction direction;

  const AnimatedButton({
    Key? key,
    required this.text,
    required this.destination,
    required this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInAnimation(
      direction: direction,
      duration: const Duration(seconds: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta,
        ),
        onPressed: () => _navigateTo(context, destination),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      ScaleSlideTransition(
        page: destination,
        isLeftScaled: false,
      ),
    );
  }
}