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
    final List<Widget> widgetList = [
      _buildTransitionButton(
        context,
        'Pop And Scale Transition',
        PopAndScaleTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Flipping Rotation Transition',
        FlippingRotationTransition(page: const SecondPage(), isReversed: false),
      ),
      _buildTransitionButton(
        context,
        'Rotation Page Transition',
        RotationPageTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Pendulum Page Transition',
        PendulumPageTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Slide Left Page Transition',
        SlideLeftPageAnimation(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Fade Page Transition',
        FadePageAnimation(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Opacity Scale Page Transition',
        OpacityScalePageTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Zoom Out Page Transition',
        ZoomOutPageTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Blink Page Transition',
        BlinkPageTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Zoom Rotate Page Transition',
        ZoomRotatePageTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Ripple Page Transition',
        RipplePageTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Shrink And Fade Transition',
        ShrinkAndFadeTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Elastic Rotation Transition',
        ElasticRotationTransition(page: const SecondPage()),
      ),
      _buildTransitionButton(
        context,
        'Scale Slide Transition',
        ScaleSlideTransition(page: const SecondPage(), isLeftScaled: true),
      ),
      _buildTransitionButton(
        context,
        'Rotation Transition',
        RotateAnimation(page: const SecondPage(), isClockwise: true),
      ),
    ];

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
                child: FadeInAnimation(child: widgetList[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransitionButton(BuildContext context, String label, Widget transition) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(context, transition);
      },
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}