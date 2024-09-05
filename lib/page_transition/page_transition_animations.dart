import 'package:animated_flutter_widgets/animated_widgets/appbars/slide_in_appbar.dart';
import 'package:animated_flutter_widgets/page_transitions/page_transition_animation.dart';
import 'package:example/page_transition/second_page.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PageTransitionAnimationWidget extends StatelessWidget {
  const PageTransitionAnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnimatedAppBar(),
      body: const TransitionGrid(),
    );
  }
}

class AnimatedAppBar extends StatelessWidget {
  const AnimatedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInAnimatedAppBar(
      title: const Text('Page Transition Catalog'),
      animationDuration: 1000,
      backgroundColor: ColorUtility.magenta,
    );
  }
}

class TransitionGrid extends StatelessWidget {
  const TransitionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TransitionButton> transitionButtons = [
      TransitionButton(
          label: 'Pop And Scale Transition',
          transition: PopAndScaleTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Flipping Rotation Transition',
          transition: FlippingRotationTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Rotation Page Transition',
          transition: RotationPageTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Pendulum Page Transition',
          transition: PendulumPageTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Slide Left Page Transition',
          transition: SlideLeftPageAnimation(page: const SecondPage())),
      TransitionButton(
          label: 'Fade Page Transition',
          transition: FadePageAnimation(page: const SecondPage())),
      TransitionButton(
          label: 'Opacity Scale Page Transition',
          transition: OpacityScalePageTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Zoom Out Page Transition',
          transition: ZoomOutPageTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Blink Page Transition',
          transition: BlinkPageTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Zoom Rotate Page Transition',
          transition: ZoomRotatePageTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Ripple Page Transition',
          transition: RipplePageTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Shrink And Fade Transition',
          transition: ShrinkAndFadeTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Elastic Rotation Transition',
          transition: ElasticRotationTransition(page: const SecondPage())),
      TransitionButton(
          label: 'Scale Slide Transition',
          transition: ScaleSlideTransition(page: const SecondPage(), isLeftScaled: true)),
      TransitionButton(
          label: 'Rotation Transition',
          transition: RotateAnimation(page: const SecondPage(), isClockwise: true)),
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimationLimiter(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: transitionButtons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final button = transitionButtons[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 600),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(child: button),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TransitionButton extends StatelessWidget {
  final String label;
  final PageTransition transition;

  const TransitionButton({Key? key, required this.label, required this.transition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () => _navigateToTransition(context),
      child: Text(label, textAlign: TextAlign.center),
    );
  }

  void _navigateToTransition(BuildContext context) {
    Navigator.push(context, transition);
  }
}