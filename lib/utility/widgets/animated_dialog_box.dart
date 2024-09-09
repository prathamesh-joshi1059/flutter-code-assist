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
    return _AnimatedDialogContent(
      title: title,
      listType: listType,
      titleTextStyle: titleTextStyle,
      actions: actions,
    );
  }
}

class _AnimatedDialogContent extends StatefulWidget {
  final String title;
  final ListType? listType;
  final TextStyle? titleTextStyle;
  final List<Widget>? actions;

  const _AnimatedDialogContent({
    Key? key,
    required this.title,
    this.listType,
    this.titleTextStyle,
    this.actions,
  }) : super(key: key);

  @override
  State<_AnimatedDialogContent> createState() => __AnimatedDialogContentState();
}

class __AnimatedDialogContentState extends State<_AnimatedDialogContent> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              title: Center(child: Text(widget.title)),
              titleTextStyle: TextStyle(
                color: ColorUtility.magenta,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              alignment: Alignment.center,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: widget.actions ?? _buildDefaultActions(context),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    final animations = [
      'Bounce Animation',
      'Fade Out Animation',
      'Scale Out Animation',
      'Water Fall Animation',
      'Left Scale Animation',
      'Right Scale Animation',
      'List Colored Animation',
    ];

    final animationTypes = [
      ScrollWidgetAnimationType.bounce,
      ScrollWidgetAnimationType.fadeOut,
      ScrollWidgetAnimationType.scaleOut,
      ScrollWidgetAnimationType.waterFall,
      ScrollWidgetAnimationType.leftScale,
      ScrollWidgetAnimationType.rightScale,
      ScrollWidgetAnimationType.listColored,
    ];

    return List.generate(animations.length, (index) {
      return Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PopAndScaleTransition(
                page: widget.listType == ListType.listView
                    ? AnimatedListView(scrollWidgetAnimationType: animationTypes[index])
                    : AnimatedGridView(scrollWidgetAnimationType: animationTypes[index]),
              ),
            );
          },
          child: Text(
            animations[index],
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}