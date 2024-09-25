// AI confidence score for this refactoring: 97.79%
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
    final List<Widget> widgetList = [
      _buildElevatedButton(
        context,
        'Steady Animation',
        const AnimationExampleWidget(
            showContineousAnimations: false,
            animationType: AnimationType.steady),
      ),
      _buildElevatedButton(
        context,
        'Continuous Animation',
        const AnimationExampleWidget(
          showContineousAnimations: true,
          animationType: AnimationType.contineous,
        ),
      ),
      _buildElevatedButton(
        context,
        'Button Tap Animation',
        const AnimationExampleWidget(
            showContineousAnimations: false,
            animationType: AnimationType.buttonTap),
      ),
      _buildDialogButton(
        context,
        'Animated ListView',
        ListType.listView,
        "Select ListView Animation",
      ),
      _buildDialogButton(
        context,
        'Animated GridView',
        ListType.gridView,
        "Select GridView Animation",
      ),
      _buildAnimatedAppBarButton(context),
    ];

    return Scaffold(
      appBar: const FadeInAnimatedAppBar(
        title: Text('Animation Catalog'),
        animationDuration: 1000,
        backgroundColor: ColorUtility.magenta,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widgetList.length,
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
                child: FadeInAnimation(child: widgetList[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildElevatedButton(
      BuildContext context, String title, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(page: page),
        );
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildDialogButton(
      BuildContext context, String title, ListType listType, String dialogTitle) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: dialogTitle,
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
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select AppBar Animation",
            actions: [
              _buildAppBarAnimationOption(context, AppBarAnimationType.slideIn, 'Slide In Animated AppBar'),
              _buildAppBarAnimationOption(context, AppBarAnimationType.fadeIn, 'Fade In Animated AppBar'),
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

  ElevatedButton _buildAppBarAnimationOption(
      BuildContext context, AppBarAnimationType animationType, String title) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(
            page: SecondPage(appBarAnimationType: animationType),
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