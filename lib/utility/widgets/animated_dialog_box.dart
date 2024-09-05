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
      child: _AnimatedDialogContent(
        title: title,
        listType: listType,
        actions: actions,
      ),
    );
  }
}

class _AnimatedDialogContent extends StatefulWidget {
  final String title;
  final ListType? listType;
  final List<Widget>? actions;

  const _AnimatedDialogContent({
    Key? key,
    required this.title,
    this.listType,
    this.actions,
  }) : super(key: key);

  @override
  State<_AnimatedDialogContent> createState() => _AnimatedDialogContentState();
}

class _AnimatedDialogContentState extends State<_AnimatedDialogContent>
    with TickerProviderStateMixin {
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: widget.actions ?? _buildDefaultActions(context),
          ),
        );
      },
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    final animations = [
      ('Bounce Animation', ScrollWidgetAnimationType.bounce),
      ('Fade Out Animation', ScrollWidgetAnimationType.fadeOut),
      ('Scale Out Animation', ScrollWidgetAnimationType.scaleOut),
      ('Water Fall Animation', ScrollWidgetAnimationType.waterFall),
      ('Left Scale Animation', ScrollWidgetAnimationType.leftScale),
      ('Right Scale Animation', ScrollWidgetAnimationType.rightScale),
      ('List Colored Animation', ScrollWidgetAnimationType.listColored),
    ];

    return animations.map((animation) {
      return Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtility.magenta,
          ),
          onPressed: () => _navigate(context, animation),
          child: Text(animation.first, textAlign: TextAlign.center),
        ),
      );
    }).toList();
  }

  void _navigate(BuildContext context, Tuple<String, ScrollWidgetAnimationType> animation) {
    final page = widget.listType == ListType.listView
        ? AnimatedListView(scrollWidgetAnimationType: animation.second)
        : AnimatedGridView(scrollWidgetAnimationType: animation.second);

    Navigator.push(
      context,
      PopAndScaleTransition(page: page),
    );
  }
}