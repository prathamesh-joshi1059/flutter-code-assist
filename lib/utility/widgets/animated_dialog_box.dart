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
      child: DialogContent(
        title: title,
        titleTextStyle: titleTextStyle ?? _defaultTitleTextStyle(),
        listType: listType,
        actions: actions ?? _defaultActions(context),
      ),
    );
  }

  TextStyle _defaultTitleTextStyle() {
    return TextStyle(
      color: ColorUtility.magenta,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );
  }

  List<Widget> _defaultActions(BuildContext context) {
    final animations = [
      ScrollWidgetAnimationType.bounce,
      ScrollWidgetAnimationType.fadeOut,
      ScrollWidgetAnimationType.scaleOut,
      ScrollWidgetAnimationType.waterFall,
      ScrollWidgetAnimationType.leftScale,
      ScrollWidgetAnimationType.rightScale,
      ScrollWidgetAnimationType.listColored,
    ];

    return animations
        .map((animation) => _buildActionButton(context, animation))
        .toList();
  }

  Widget _buildActionButton(BuildContext context, ScrollWidgetAnimationType animation) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtility.magenta,
        ),
        onPressed: () => _navigateToNextPage(context, animation),
        child: Text(
          _getButtonText(animation),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _getButtonText(ScrollWidgetAnimationType animation) {
    switch (animation) {
      case ScrollWidgetAnimationType.bounce:
        return 'Bounce Animation';
      case ScrollWidgetAnimationType.fadeOut:
        return 'Fade Out Animation';
      case ScrollWidgetAnimationType.scaleOut:
        return 'Scale Out Animation';
      case ScrollWidgetAnimationType.waterFall:
        return 'Water Fall Animation';
      case ScrollWidgetAnimationType.leftScale:
        return 'Left Scale Animation';
      case ScrollWidgetAnimationType.rightScale:
        return 'Right Scale Animation';
      case ScrollWidgetAnimationType.listColored:
        return 'List Colored Animation';
      default:
        return '';
    }
  }

  void _navigateToNextPage(BuildContext context, ScrollWidgetAnimationType animation) {
    final page = listType == ListType.listView
        ? const AnimatedListView(scrollWidgetAnimationType: animation)
        : const AnimatedGridView(scrollWidgetAnimationType: animation);

    Navigator.push(
      context,
      PopAndScaleTransition(page: page),
    );
  }
}

class DialogContent extends StatefulWidget {
  final String title;
  final TextStyle titleTextStyle;
  final ListType? listType;
  final List<Widget> actions;

  const DialogContent({
    Key? key,
    required this.title,
    required this.titleTextStyle,
    required this.listType,
    required this.actions,
  }) : super(key: key);

  @override
  _DialogContentState createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> with TickerProviderStateMixin {
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Center(child: Text(widget.title, style: widget.titleTextStyle)),
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: widget.actions,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}