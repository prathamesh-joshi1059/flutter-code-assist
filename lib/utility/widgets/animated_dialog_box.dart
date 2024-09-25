// AI confidence score for this refactoring: 95.40%
import 'package:animated_flutter_widgets/page_transitions/page_transition_animation.dart';
import 'package:animated_flutter_widgets/enums/enums.dart';
import 'package:example/animation/animated_grid_view.dart';
import 'package:example/animation/animated_list_view.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';

class AnimatedDialogBox extends StatelessWidget {
  final String title;
  final ListType? listType;
  final TextStyle? titleTextStyle;
  final List<Widget>? actions;

  const AnimatedDialogBox({
    Key? key,
    required this.title,
    this.titleTextStyle,
    this.listType,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = AnimationController(
      vsync: const TestVSync(),
      duration: const Duration(milliseconds: 500),
    );

    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    controller.forward();

    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: animation.value,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              title: Center(child: Text(title)),
              titleTextStyle: titleTextStyle ??
                  const TextStyle(
                    color: ColorUtility.magenta,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
              alignment: Alignment.center,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: actions ?? _buildActions(context),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final List<ScrollWidgetAnimationType> animationTypes = [
      ScrollWidgetAnimationType.bounce,
      ScrollWidgetAnimationType.fadeOut,
      ScrollWidgetAnimationType.scaleOut,
      ScrollWidgetAnimationType.waterFall,
      ScrollWidgetAnimationType.leftScale,
      ScrollWidgetAnimationType.rightScale,
      ScrollWidgetAnimationType.listColored,
    ];

    return List.generate(animationTypes.length, (index) {
      return Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () {
            final page = listType == ListType.listView
                ? AnimatedListView(scrollWidgetAnimationType: animationTypes[index])
                : AnimatedGridView(scrollWidgetAnimationType: animationTypes[index]);
            Navigator.push(context, PopAndScaleTransition(page: page));
          },
          child: Text(
            animationTypes[index].toString().split('.').last.replaceAll('Animation', '').replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match[0]}').trim(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }
}

class TestVSync implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}