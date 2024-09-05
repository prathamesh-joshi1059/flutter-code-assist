import 'package:animated_flutter_widgets/animated_widgets/appbars/fade_in_appbar.dart';
import 'package:animated_flutter_widgets/animated_widgets/scroll_widget/animated_listview_builder.dart';
import 'package:animated_flutter_widgets/enums/enums.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatelessWidget {
  final ScrollWidgetAnimationType scrollWidgetAnimationType;

  const AnimatedListView({
    Key? key,
    required this.scrollWidgetAnimationType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AnimatedAppBar(),
      body: const _AnimatedListViewBody(),
    );
  }
}

class _AnimatedAppBar extends StatelessWidget {
  const _AnimatedAppBar();

  @override
  Widget build(BuildContext context) {
    return FadeInAnimatedAppBar(
      backgroundColor: ColorUtility.magenta,
      title: const Text('Animated ListView'),
    );
  }
}

class _AnimatedListViewBody extends StatelessWidget {
  const _AnimatedListViewBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedListViewBuilder(
        itemCount: 25,
        customColor: ColorUtility.magenta,
        animationType: ScrollWidgetAnimationType.listColored,
        itemBuilder: _buildListItem,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final isColored = ScrollWidgetAnimationType.listColored;

    return Card(
      color: isColored ? ColorUtility.white : ColorUtility.magenta,
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Item $index',
            style: TextStyle(
              color: isColored ? ColorUtility.magenta : ColorUtility.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}