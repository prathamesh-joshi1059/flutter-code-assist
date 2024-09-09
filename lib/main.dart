import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:example/animation/animation_catlog.dart';
import 'package:example/page_transition/page_transition_animations.dart';
import 'package:example/utility/color.dart';

void main() {
  runApp(const MyApp());
}

void initializeData(BuildContext context) {
  print("Data initialized");
  Navigator.push(
    context,
    ScaleSlideTransition(
      page: const PageTransitionAnimationWidget(),
      isLeftScaled: false,
    ),
  );
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
            SlideInAnimation(
              direction: Direction.down,
              duration: const Duration(seconds: 1),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtility.magenta,
                ),
                onPressed: () => initializeData(context),
                child: const Text(
                  'Page Transition Animations',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SlideInAnimation(
              direction: Direction.up,
              duration: const Duration(seconds: 1),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtility.magenta,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PopAndScaleTransition(page: const AnimationCatlog()),
                  );
                },
                child: const Text(
                  'Animations',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}