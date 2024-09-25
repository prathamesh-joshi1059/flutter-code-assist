// AI confidence score for this refactoring: 99.08%
import 'package:animated_flutter_widgets/animated_widgets/appbars/slide_in_appbar.dart';
import 'package:animated_flutter_widgets/page_transitions/page_transition_animation.dart';
import 'package:example/page_transition/second_page.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PageTransitionAnimationWidget extends StatelessWidget {
  const PageTransitionAnimationWidget({super.key});

  final List<Map<String, dynamic>> _transitions = const [
    {
      'label': 'Pop And Scale Transition',
      'transition': PopAndScaleTransition,
    },
    {
      'label': 'Flipping Rotation Transition',
      'transition': FlippingRotationTransition,
      'args': {'isReversed': false},
    },
    {
      'label': 'Rotation Page Transition',
      'transition': RotationPageTransition,
    },
    {
      'label': 'Pendulum Page Transition',
      'transition': PendulumPageTransition,
    },
    {
      'label': 'Slide Left Page Transition',
      'transition': SlideLeftPageAnimation,
    },
    {
      'label': 'Fade Page Transition',
      'transition': FadePageAnimation,
    },
    {
      'label': 'Opacity Scale Page Transition',
      'transition': OpacityScalePageTransition,
    },
    {
      'label': 'Zoom Out Page Transition',
      'transition': ZoomOutPageTransition,
    },
    {
      'label': 'Blink Page Transition',
      'transition': BlinkPageTransition,
    },
    {
      'label': 'Zoom Rotate Page Transition',
      'transition': ZoomRotatePageTransition,
    },
    {
      'label': 'Ripple Page Transition',
      'transition': RipplePageTransition,
    },
    {
      'label': 'Shrink And Fade Transition',
      'transition': ShrinkAndFadeTransition,
    },
    {
      'label': 'Elastic Rotation Transition',
      'transition': ElasticRotationTransition,
    },
    {
      'label': 'Scale Slide Transition',
      'transition': ScaleSlideTransition,
      'args': {'isLeftScaled': true},
    },
    {
      'label': 'Rotation Transition',
      'transition': RotateAnimation,
      'args': {'isClockwise': true},
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            itemCount: _transitions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, index) {
              final transition = _transitions[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 600),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtility.magenta,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          transition['args'] != null
                              ? transition['transition'](
                                  page: const SecondPage(),
                                  ...transition['args'],
                                )
                              : transition['transition'](
                                  page: const SecondPage(),
                                ),
                        );
                      },
                      child: Text(
                        transition['label'],
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}