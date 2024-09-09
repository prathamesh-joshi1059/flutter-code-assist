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

class AnimationCatlog extends StatefulWidget {
  const AnimationCatlog({Key? key}) : super(key: key);

  @override
  State<AnimationCatlog> createState() => _AnimationCatlogState();
}

class _AnimationCatlogState extends State<AnimationCatlog>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widgetList = _buildWidgetList(context);

    return Scaffold(
      appBar: FadeInAnimatedAppBar(
        title: const Text('Animation Catlog'),
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

  List<Widget> _buildWidgetList(BuildContext context) {
    return [
      _buildElevatedButton(
        context,
        'Steady Animation',
        AnimationExampleWidget(
          showContineousAnimations: false,
          animationType: AnimationType.steady,
        ),
      ),
      _buildElevatedButton(
        context,
        'Continuous Animation',
        AnimationExampleWidget(
          showContineousAnimations: true,
          animationType: AnimationType.contineous,
        ),
      ),
      _buildElevatedButton(
        context,
        'Button Tap Animation',
        AnimationExampleWidget(
          showContineousAnimations: false,
          animationType: AnimationType.buttonTap,
        ),
      ),
      _buildDialogButton(
        context,
        'Animated ListView',
        "Select ListView Animation",
        ListType.listView,
      ),
      _buildDialogButton(
        context,
        'Animated GridView',
        "Select GridView Animation",
        ListType.gridView,
      ),
      _buildAnimatedAppBarButton(context),
    ];
  }

  ElevatedButton _buildElevatedButton(
      BuildContext context, String label, Widget page) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(page: page),
        );
      },
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildDialogButton(
      BuildContext context, String label, String title, ListType listType) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: title,
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

  ElevatedButton _buildAnimatedAppBarButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select AppBar Animation",
            actions: [
              _buildAppBarAnimationOption(
                context,
                'Slide In Animated AppBar',
                AppBarAnimationType.slideIn,
              ),
              _buildAppBarAnimationOption(
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

  ElevatedButton _buildAppBarAnimationOption(
      BuildContext context, String label, AppBarAnimationType type) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(
            page: SecondPage(appBarAnimationType: type),
          ),
        );
      },
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}