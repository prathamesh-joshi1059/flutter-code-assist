import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:example/animation/animation_catlog.dart';
import 'package:example/page_transition/page_transition_animations.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SlideInAnimation for Page Transition Animations button
            SlideInAnimation(
              direction: Direction.down,
              duration: const Duration(seconds: 1),
              child: AnimatedButton(
                context: context,
                label: 'Page Transition Animations',
                destination: const PageTransitionAnimationWidget(),
              ),
            ),

            // SlideInAnimation for Animations button
            SlideInAnimation(
              direction: Direction.up,
              duration: const Duration(seconds: 1),
              child: AnimatedButton(
                context: context,
                label: 'Animations',
                destination: const AnimationCatlog(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final BuildContext context;
  final String label;
  final Widget destination;

  const AnimatedButton({
    Key? key,
    required this.context,
    required this.label,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () {
        Navigator.push(
          context,
          ScaleSlideTransition(page: destination, isLeftScaled: false),
        );
      },
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}