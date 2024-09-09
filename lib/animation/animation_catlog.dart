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
      _buildAnimationButton(
        context,
        title: 'Steady Animation',
        animationType: AnimationType.steady,
        showContinuousAnimations: false,
      ),
      _buildAnimationButton(
        context,
        title: 'Continuous Animation',
        animationType: AnimationType.contineous,
        showContinuousAnimations: true,
      ),
      _buildAnimationButton(
        context,
        title: 'Button Tap Animation',
        animationType: AnimationType.buttonTap,
        showContinuousAnimations: false,
      ),
      _buildListViewButton(context),
      _buildGridViewButton(context),
      _buildAppBarButton(context),
    ];

    return Scaffold(
      appBar: FadeInAnimatedAppBar(
        title: const Text('Animation Catalog'),
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

  ElevatedButton _buildAnimationButton(BuildContext context,
      {required String title,
      required AnimationType animationType,
      required bool showContinuousAnimations}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
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

  ElevatedButton _buildListViewButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AnimatedDialogBox(
              title: "Select ListView Animation",
              listType: ListType.listView),
        );
      },
      child: const Text(
        'Animated ListView',
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildGridViewButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AnimatedDialogBox(
            title: "Select GridView Animation",
            listType: ListType.gridView,
          ),
        );
      },
      child: const Text(
        'Animated GridView',
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildAppBarButton(BuildContext context) {
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
              _buildAppBarActionButton(
                context,
                title: 'Slide In Animated AppBar',
                animationType: AppBarAnimationType.slideIn,
              ),
              _buildAppBarActionButton(
                context,
                title: 'Fade In Animated AppBar',
                animationType: AppBarAnimationType.fadeIn,
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

  ElevatedButton _buildAppBarActionButton(
      BuildContext context, {
      required String title,
      required AppBarAnimationType animationType}) {
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