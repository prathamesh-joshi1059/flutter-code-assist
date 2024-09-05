import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:example/animation/animation_catlog.dart';
import 'package:example/page_transition/page_transition_animations.dart';
import 'package:example/utility/color.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget for the Flutter app.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Animations(),
    );
  }
}

/// The main widget that displays animations in the app.
class Animations extends StatelessWidget {
  const Animations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.magenta,
        title: const Text("Animation Widget Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSlideInButton(
              context,
              'Page Transition Animations',
              const PageTransitionAnimationWidget(),
              Direction.down,
            ),
            const SizedBox(height: 20),
            _buildSlideInButton(
              context,
              'Animations',
              const AnimationCatlog(),
              Direction.up,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlideInButton(BuildContext context, String label, Widget page, Direction direction) {
    return SlideInAnimation(
      direction: direction,
      duration: const Duration(seconds: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta,
        ),
        onPressed: () {
          Navigator.push(
            context,
            PopAndScaleTransition(page: page),
          );
        },
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}