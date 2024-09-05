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
      appBar: FadeInAnimatedAppBar(
        title: const Text('Animation Catalog'),
        animationDuration: 1000,
        backgroundColor: ColorUtility.magenta,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AnimationLimiter(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.76,
            crossAxisSpacing: 18,
            mainAxisSpacing: 12,
            children: _buildAnimationButtons(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAnimationButtons(BuildContext context) {
    return [
      _buildElevatedButton(
        context,
        'Steady Animation',
        AnimationType.steady,
        false,
      ),
      _buildElevatedButton(
        context,
        'Continuous Animation',
        AnimationType.contineous,
        true,
      ),
      _buildElevatedButton(
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
      _buildAnimatedAppBarButton(context),
    ];
  }

  ElevatedButton _buildElevatedButton(
    BuildContext context,
    String title,
    AnimationType animationType,
    bool showContinuousAnimations,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(
            page: AnimationExampleWidget(
              showContineousAnimations: showContinuousAnimations,
              animationType: animationType,
            ),
          ),
        );
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildDialogButton(
    BuildContext context,
    String title,
    ListType listType,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select ${title.split(' ')[1]} Animation",
            listType: listType,
          ),
        );
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildAnimatedAppBarButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select AppBar Animation",
            actions: [
              _buildAppBarAnimationButton(
                context,
                'Slide In Animated AppBar',
                AppBarAnimationType.slideIn,
              ),
              _buildAppBarAnimationButton(
                context,
                'Fade In Animated AppBar',
                AppBarAnimationType.fadeIn,
              ),
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

  ElevatedButton _buildAppBarAnimationButton(
    BuildContext context,
    String title,
    AppBarAnimationType appBarAnimationType,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(
            page: SecondPage(appBarAnimationType: appBarAnimationType),
          ),
        );
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}