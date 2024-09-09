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
      body: const AnimationCatalogBody(),
    );
  }
}

class AnimationCatalogBody extends StatefulWidget {
  const AnimationCatalogBody({Key? key}) : super(key: key);

  @override
  State<AnimationCatalogBody> createState() => _AnimationCatalogBodyState();
}

class _AnimationCatalogBodyState extends State<AnimationCatalogBody>
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

  List<Widget> _buildAnimationButtons(BuildContext context) {
    return [
      _buildButton(
          context, 'Steady Animation', AnimationType.steady, false),
      _buildButton(
          context, 'Continuous Animation', AnimationType.contineous, true),
      _buildButton(
          context, 'Button Tap Animation', AnimationType.buttonTap, false),
      _buildDialogButton(context, 'Animated ListView', ListType.listView),
      _buildDialogButton(context, 'Animated GridView', ListType.gridView),
      _buildAppBarAnimationButton(context),
    ];
  }

  Widget _buildButton(BuildContext context, String label,
      AnimationType type, bool showContinuousAnimations) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta),
      onPressed: () {
        Navigator.push(
          context,
          PopAndScaleTransition(
            page: AnimationExampleWidget(
              showContineousAnimations: showContinuousAnimations,
              animationType: type,
            ),
          ),
        );
      },
      child: Text(label, textAlign: TextAlign.center),
    );
  }

  Widget _buildDialogButton(BuildContext context, String label, ListType type) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select $label Animation",
            listType: type,
          ),
        );
      },
      child: Text(label, textAlign: TextAlign.center),
    );
  }

  Widget _buildAppBarAnimationButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AnimatedDialogBox(
            title: "Select AppBar Animation",
            actions: [
              _buildAppBarAction(
                  context, 'Slide In Animated AppBar', AppBarAnimationType.slideIn),
              _buildAppBarAction(
                  context, 'Fade In Animated AppBar', AppBarAnimationType.fadeIn),
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

  Widget _buildAppBarAction(BuildContext context, String label, AppBarAnimationType type) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta),
        onPressed: () {
          Navigator.push(
            context,
            PopAndScaleTransition(
              page: SecondPage(appBarAnimationType: type),
            ),
          );
        },
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = _buildAnimationButtons(context);

    return Padding(
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
    );
  }
}