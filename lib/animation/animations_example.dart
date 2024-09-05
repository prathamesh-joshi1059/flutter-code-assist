import 'package:animated_flutter_widgets/animated_widgets.dart';
import 'package:animated_flutter_widgets/animations/bounce_animations.dart';
import 'package:example/utility/color.dart';
import 'package:example/utility/enums.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationExampleWidget extends StatelessWidget {
  final bool showContinuousAnimations;
  final AnimationType? animationType;

  const AnimationExampleWidget({
    Key? key,
    required this.showContinuousAnimations,
    required this.animationType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = _getAnimationWidgets(animationType);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
        backgroundColor: ColorUtility.magenta,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: widgets[index],
          );
        },
      ),
    );
  }

  List<Widget> _getAnimationWidgets(AnimationType? animationType) {
    switch (animationType) {
      case AnimationType.contineous:
        return _continuousAnimations();
      case AnimationType.steady:
        return _steadyAnimations();
      case AnimationType.buttonTap:
        return _buttonTapAnimations();
      default:
        return [];
    }
  }

  List<Widget> _continuousAnimations() {
    return [
      _pathAnimation(),
      _pulseAnimation(),
      _rotation3DAnimation(Direction.right),
      _shakeAnimation(),
      _rotation3DAnimation(Direction.down),
      _dropletAnimation(),
      _cube3DAnimation(),
      _circular2DAnimation(),
    ];
  }

  List<Widget> _steadyAnimations() {
    return [
      _slideInAnimation(Direction.right),
      _slideInAnimation(Direction.down),
      _slideInAnimation(Direction.up),
      _slideInAnimation(Direction.left),
      _rotation3DAnimation(Direction.left),
      _rotation3DAnimation(Direction.right),
      _rotation3DAnimation(Direction.up),
      _rotation3DAnimation(Direction.down),
      _bounceAnimation(),
      _dropAndBounceAnimation(),
      _fastOutSlowInAnimation(),
      _rotationAnimation(),
      _easeInAnimation(),
    ];
  }

  List<Widget> _buttonTapAnimations() {
    return [
      _longTapAnimation(),
      _buttonTapAnimation(),
      _doubleTapAnimation(),
    ];
  }

  Widget _pathAnimation() {
    return PathAnimation(
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
    );
  }

  Widget _pulseAnimation() {
    return PulseAnimation(
      child: HeartShape(
        width: 100,
        height: 100,
        color: ColorUtility.magenta,
      ),
    );
  }

  Widget _rotation3DAnimation(Direction direction) {
    return Rotation3DAnimation(
      angle: math.pi,
      duration: const Duration(milliseconds: 1000),
      direction: direction,
      isContinuous: true,
      isHalfRotation: false,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: Text('3D Rotation ${direction.toString().split('.').last} Animation'),
      ),
    );
  }

  Widget _shakeAnimation() {
    return ShakeAnimation(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text('Shake Animation'),
      ),
    );
  }

  Widget _dropletAnimation() {
    return DropletAnimation(
      width: 5,
      height: 5,
      verticalDistance: 64,
      child: CustomPaint(
        size: const Size(100, 150),
        painter: WaterDropletPainter(dropColor: ColorUtility.magenta),
      ),
    );
  }

  Widget _cube3DAnimation() {
    return Cube3DAnimation(
      sideLength: 100,
      duration: const Duration(seconds: 4),
      isContinuous: true,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text(
          'Cube 3D Animation',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _circular2DAnimation() {
    return Circular2DAnimation(
      radius: 150,
      initialAngle: 0,
      duration: const Duration(seconds: 4),
      isContinuous: true,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text(
          'Circular 2D Animation',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _slideInAnimation(Direction direction) {
    return SlideInAnimation(
      direction: direction,
      duration: const Duration(seconds: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text(
          'Slide In ${direction.toString().split('.').last} Animation',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _bounceAnimation() {
    return BounceAnimation(
      beginScale: 0.2,
      duration: const Duration(seconds: 2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text('Bounce Animation'),
      ),
    );
  }

  Widget _dropAndBounceAnimation() {
    return DropAndBounceAnimation(
      distance: 100.0,
      duration: 1000,
      child: SizedBox(
        width: 110,
        height: 110,
        child: CircleAvatar(
          backgroundColor: ColorUtility.magenta,
          child: Center(
            child: Text(
              "Drop and Bounce Animation",
              style: TextStyle(color: ColorUtility.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _fastOutSlowInAnimation() {
    return FastOutSlowInAnimation(
      duration: const Duration(seconds: 1),
      scale: 1,
      child: SizedBox(
        width: 110,
        height: 110,
        child: CustomPaint(
          painter: StarPainter(
            starColor: ColorUtility.magenta,
            centerText: 'Fast Out Slow Animation',
            centerTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 6,
            ),
          ),
        ),
      ),
    );
  }

  Widget _rotationAnimation() {
    return RotationAnimation(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text('Rotation Animation'),
      ),
    );
  }

  Widget _easeInAnimation() {
    return EaseInAnimation(
      duration: const Duration(seconds: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text('Fade In Animation'),
      ),
    );
  }

  Widget _longTapAnimation() {
    return LongTapAnimation(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text('Long Press Me'),
      ),
    );
  }

  Widget _buttonTapAnimation() {
    return ButtonTapAnimation(
      duration: const Duration(milliseconds: 300),
      scaleValue: 0.5,
      onTapUp: () {},
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta,
          disabledBackgroundColor: ColorUtility.magenta,
        ),
        onPressed: null,
        child: Text(
          'Tap Me',
          style: TextStyle(color: ColorUtility.white),
        ),
      ),
    );
  }

  Widget _doubleTapAnimation() {
    return DoubleTapAnimation(
      duration: const Duration(milliseconds: 200),
      scaleValue: 0.95,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {},
        child: const Text('Double Tap Me'),
      ),
    );
  }
}