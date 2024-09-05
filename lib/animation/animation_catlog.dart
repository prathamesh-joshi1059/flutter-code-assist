import 'package:animated_flutter_widgets/animated_widgets/appbars/fade_in_appbar.dart';
import 'package:animated_flutter_widgets/page_transitions/page_transition_animation.dart';
import 'package:animated_flutter_widgets/enums/enums.dart';
import 'package:example/animation/animations_example.dart';
import 'package:example/page_transition/second_page.dart';
import 'package:example/utility/color.dart';
import 'package:example/utility/enums.dart';
import 'package:example/utility/widgets/animated_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimationCatalog extends StatelessWidget {
  const AnimationCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FadeInAnimatedAppBar(
        title: Text('Animation Catalog'),
        animationDuration: 1000,
        backgroundColor: ColorUtility.magenta,
      ),
      body: const AnimationCatalogBody(),
    );
  }
}

class AnimationCatalogBody extends StatelessWidget {
  const AnimationCatalogBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> animationButtons = [
      _buildAnimationButton(
        context,
        'Steady Animation',
        AnimationType.steady,
        false,
      ),
      _buildAnimationButton(
        context,
        'Continuous Animation',
        AnimationType.contineous,
        true,
      ),
      _buildAnimationButton(
        context,
        'Button Tap Animation',
        AnimationType.buttonTap,
        false,
      ),
      _buildDialogButton(
        context,
        'Animated ListView',
        ListType.listView,
      ),
      _buildDialogButton(
        context,
        'Animated GridView',
        ListType.gridView,
      ),
      _buildAppBarAnimationButton(context),
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimationLimiter(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: animationButtons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.76,
            crossAxisSpacing: 18,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(child: animationButtons[index]),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildAnimationButton(BuildContext context, String label, AnimationType animationType, bool showContinuous) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(
            page: AnimationExampleWidget(
              showContineousAnimations: showContinuous,
              animationType: animationType,
            ),
          ),
        );
      },
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildDialogButton(BuildContext context, String label, ListType listType) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select ${label.split(' ')[1]} Animation",
            listType: listType,
          ),
        );
      },
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildAppBarAnimationButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select AppBar Animation",
            actions: [
              _buildAppBarOption(context, AppBarAnimationType.slideIn, 'Slide In Animated AppBar'),
              _buildAppBarOption(context, AppBarAnimationType.fadeIn, 'Fade In Animated AppBar'),
            ],
          ),
        );
      },
      child: const Text(
        'Animated AppBar',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAppBarOption(BuildContext context, AppBarAnimationType animationType, String label) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
        onPressed: () {
          Navigator.push(
            context,
            PopAndScaleTransition(
              page: SecondPage(appBarAnimationType: animationType),
            ),
          );
        },
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}