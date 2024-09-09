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
    return Center(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Center(child: Text(title)),
        titleTextStyle: TextStyle(
          color: ColorUtility.magenta,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        content: _buildAnimationButtons(context),
      ),
    );
  }

  Widget _buildAnimationButtons(BuildContext context) {
    final animations = [
      ScrollWidgetAnimationType.bounce,
      ScrollWidgetAnimationType.fadeOut,
      ScrollWidgetAnimationType.scaleOut,
      ScrollWidgetAnimationType.waterFall,
      ScrollWidgetAnimationType.leftScale,
      ScrollWidgetAnimationType.rightScale,
      ScrollWidgetAnimationType.listColored,
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: animations.map((animation) {
        return Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorUtility.magenta,
            ),
            onPressed: () {
              final isListView = listType == ListType.listView;
              final page = isListView
                  ? AnimatedListView(scrollWidgetAnimationType: animation)
                  : AnimatedGridView(scrollWidgetAnimationType: animation);

              Navigator.push(
                context,
                PopAndScaleTransition(page: page),
              );
            },
            child: Text(
              '${animation.toString().split('.').last} Animation',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}