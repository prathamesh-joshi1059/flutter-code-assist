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
      home: const Animations(),
    );
  }
}

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
            _buildPageTransitionButton(context, 'Page Transition Animations', ScaleSlideTransition(
              page: const PageTransitionAnimationWidget(),
              isLeftScaled: false,
            ), Direction.down),
            _buildPageTransitionButton(context, 'Animations', PopAndScaleTransition(page: const AnimationCatlog()), Direction.up),
          ],
        ),
      ),
    );
  }

  Widget _buildPageTransitionButton(BuildContext context, String title, Widget page, Direction direction) {
    return SlideInAnimation(
      direction: direction,
      duration: const Duration(seconds: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta,
        ),
        onPressed: () => _navigateToPage(context, page),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, page);
  }
}