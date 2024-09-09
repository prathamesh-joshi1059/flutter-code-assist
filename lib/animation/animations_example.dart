import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:animated_flutter_widgets/animations/bounce_animations.dart';
import 'package:example/utility/color.dart';
import 'package:example/utility/enums.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationExampleWidget extends StatelessWidget {
  final bool showContinuousAnimations; // Corrected spelling
  final AnimationType? animationType;

  const AnimationExampleWidget({
    super.key,
    required this.showContinuousAnimations,
    required this.animationType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
        backgroundColor: ColorUtility.magenta,
      ),
      body: AnimationGrid(animationType: animationType!),
    );
  }
}

class AnimationGrid extends StatefulWidget {
  final AnimationType animationType;

  const AnimationGrid({required this.animationType});

  @override
  State<AnimationGrid> createState() => _AnimationGridState();
}

class _AnimationGridState extends State<AnimationGrid> {
  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();
    getAnimationData();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: widgetList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: widgetList[index],
        );
      },
    );
  }

  void getAnimationData() {
    try {
      switch (widget.animationType) {
        case AnimationType.continous:
          widgetList = _getContinuousAnimations();
          break;
        case AnimationType.steady:
          widgetList = _getSteadyAnimations();
          break;
        case AnimationType.buttonTap:
          widgetList = _getButtonTapAnimations();
          break;
        default:
          widgetList = [];
      }
    } catch (e) {
      // Handle errors
      print('Error loading animations: $e');
      widgetList = [];
    }
    setState(() {});
  }

  List<Widget> _getContinuousAnimations() {
    return [
      PathAnimation(
        reversePath: true,
        path: Path()
          ..moveTo(0, 0)
          ..lineTo(200, 0)
          ..lineTo(200, 200)
          ..lineTo(0, 200)
          ..close(),
        duration: const Duration(seconds: 4),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: ColorUtility.magenta,
        ),
      ),
      PulseAnimation(
        child: HeartShape(
          width: 100,
          height: 100,
          color: ColorUtility.magenta,
        ),
      ),
      Rotation3DAnimation(
        angle: math.pi,
        duration: const Duration(milliseconds: 1000),
        direction: Direction.right,
        isContinuous: true,
        child: Container(
          child: ImageColorChangeAnimationUtility.animatedColorImage(
            imagePath: 'assets/images/walkfor1min.png',
            initialColor: Colors.blue,
            colorArray: [
              Colors.green,
              Colors.blue,
              Colors.red,
              Colors.purple,
            ],
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
      ShakeAnimation(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () {},
          child: const Text('Shake Animation'),
        ),
      ),
      Cube3DAnimation(
        sideLength: 100,
        duration: const Duration(seconds: 4),
        isContinuous: true,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () {},
          child: const Text('Cube 3D Animation'),
        ),
      ),
      Circular2DAnimation(
        radius: 150,
        initialAngle: 0,
        duration: const Duration(seconds: 4),
        isContinuous: true,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () {},
          child: const Text('Circular 2D Animation'),
        ),
      ),
    ];
  }

  List<Widget> _getSteadyAnimations() {
    return [
      SlideInAnimation(
        direction: Direction.right,
        duration: const Duration(seconds: 1),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () {},
          child: const Text('Slide In Right Animation',
              style: TextStyle(color: Colors.white)),
        ),
      ),
      // Other steady animations...
    ];
  }

  List<Widget> _getButtonTapAnimations() {
    return [
      LongTapAnimation(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () {},
          child: const Text('Long Press Me'),
        ),
      ),
      // Other button tap animations...
    ];
  }
}