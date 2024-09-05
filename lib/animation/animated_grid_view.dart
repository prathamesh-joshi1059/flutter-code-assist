import 'package:animated_flutter_widgets/animated_widgets/appbars/fade_in_appbar.dart';
import 'package:animated_flutter_widgets/animated_widgets/scroll_widget/animated_gridview_builder.dart';
import 'package:animated_flutter_widgets/enums/enums.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';

class AnimatedGridView extends StatelessWidget {
  final ScrollWidgetAnimationType scrollWidgetAnimationType;

  const AnimatedGridView({
    Key? key,
    required this.scrollWidgetAnimationType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildGridView(),
    );
  }

  AppBar _buildAppBar() {
    return FadeInAnimatedAppBar(
      backgroundColor: ColorUtility.magenta,
      title: const Text('Animated GridView'),
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedGridViewBuilder(
        itemCount: 25,
        colorChangeHighlightColor: ColorUtility.magenta,
        animationType: scrollWidgetAnimationType,
        itemBuilder: _buildGridItem,
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    final bool isListColored = scrollWidgetAnimationType == ScrollWidgetAnimationType.listColored;
    final Color cardColor = isListColored ? ColorUtility.white : ColorUtility.magenta;
    final Color textColor = isListColored ? ColorUtility.magenta : ColorUtility.white;

    return Card(
      color: cardColor,
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Item $index',
            style: TextStyle(
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}