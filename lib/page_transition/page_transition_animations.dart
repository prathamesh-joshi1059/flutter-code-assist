import 'package:animated_flutter_widgets/animated_widgets/appbars/slide_in_appbar.dart';
import 'package:animated_flutter_widgets/page_transitions/page_transition_animation.dart';
import 'package:example/page_transition/second_page.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PageTransitionAnimationWidget extends StatelessWidget {
  const PageTransitionAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = _buildTransitionButtons(context);

    return Scaffold(
      appBar: SlideInAnimatedAppBar(
        title: const Text('Page Transition Catalog'),
        animationDuration: 1000,
        backgroundColor: ColorUtility.magenta,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: widgetList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, index) => AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 600),
              columnCount: 2,
              child: ScaleAnimation(
                  child: FadeInAnimation(child: widgetList[index])),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTransitionButtons(BuildContext context) {
    return [
      _buildTransitionButton(context, const SecondPage(), 'Pop And Scale Transition', PopAndScaleTransition),
      _buildTransitionButton(context, const SecondPage(), 'Flipping Rotation Transition', FlippingRotationTransition),
      _buildTransitionButton(context, const SecondPage(), 'Rotation Page Transition', RotationPageTransition),
      _buildTransitionButton(context, const SecondPage(), 'Pendulum Page Transition', PendulumPageTransition),
      _buildTransitionButton(context, const SecondPage(), 'Slide Left Page Transition', SlideLeftPageAnimation),
      _buildTransitionButton(context, const SecondPage(), 'Fade Page Transition', FadePageAnimation),
      _buildTransitionButton(context, const SecondPage(), 'Opacity Scale Page Transition', OpacityScalePageTransition),
      _buildTransitionButton(context, const SecondPage(), 'Zoom Out Page Transition', ZoomOutPageTransition),
      _buildTransitionButton(context, const SecondPage(), 'Blink Page Transition', BlinkPageTransition),
      _buildTransitionButton(context, const SecondPage(), 'Zoom Rotate Page Transition', ZoomRotatePageTransition),
      _buildTransitionButton(context, const SecondPage(), 'Ripple Page Transition', RipplePageTransition),
      _buildTransitionButton(context, const SecondPage(), 'Shrink And Fade Transition', ShrinkAndFadeTransition),
      _buildTransitionButton(context, const SecondPage(), 'Elastic Rotation Transition', ElasticRotationTransition),
      _buildTransitionButton(context, const SecondPage(), 'Scale Slide Transition', ScaleSlideTransition, isLeftScaled: true),
      _buildTransitionButton(context, const SecondPage(), 'Rotation Transition', RotateAnimation, isClockwise: true),
    ];
  }

  ElevatedButton _buildTransitionButton(BuildContext context, Widget page, String label, Type transitionType, {bool isLeftScaled = false, bool isClockwise = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(
          context,
          transitionType(page: page, isLeftScaled: isLeftScaled, isClockwise: isClockwise),
        );
      },
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}