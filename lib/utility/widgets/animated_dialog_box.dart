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
      child: DialogAnimator(
        title: title,
        listType: listType,
        actions: actions,
      ),
    );
  }
}

class DialogAnimator extends StatefulWidget {
  final String title;
  final ListType? listType;
  final List<Widget>? actions;

  const DialogAnimator({
    Key? key,
    required this.title,
    this.listType,
    this.actions,
  }) : super(key: key);

  @override
  State<DialogAnimator> createState() => _DialogAnimatorState();
}

class _DialogAnimatorState extends State<DialogAnimator> with TickerProviderStateMixin {
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

  void _navigateToAnimationPage(ScrollWidgetAnimationType animationType) {
    final page = widget.listType == ListType.listView
        ? AnimatedListView(scrollWidgetAnimationType: animationType)
        : AnimatedGridView(scrollWidgetAnimationType: animationType);

    Navigator.push(
      context,
      PopAndScaleTransition(page: page),
    );
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
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Center(child: Text(widget.title)),
            titleTextStyle: const TextStyle(
                color: ColorUtility.magenta,
                fontSize: 22,
                fontWeight: FontWeight.bold),
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: widget.actions ?? _buildDefaultActions(),
          ),
        );
      },
    );
  }

  List<Widget> _buildDefaultActions() {
    final animations = [
      ScrollWidgetAnimationType.bounce,
      ScrollWidgetAnimationType.fadeOut,
      ScrollWidgetAnimationType.scaleOut,
      ScrollWidgetAnimationType.waterFall,
      ScrollWidgetAnimationType.leftScale,
      ScrollWidgetAnimationType.rightScale,
      ScrollWidgetAnimationType.listColored,
    ];

    return animations.map((animationType) {
      return Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorUtility.magenta),
          onPressed: () => _navigateToAnimationPage(animationType),
          child: Text(
            animationType.toString().split('.').last
                .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match[0]}')
                .trim()
                .splitMapJoin(
                  RegExp(r'[' r'-' ']'),
                  onMatch: (m) => '',
                  onNonMatch: (n) => n,
                )
                .replaceFirst('Animation', ''),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}