import 'package:animated_flutter_widgets/animated_widgets/appbars/fade_in_appbar.dart';
import 'package:animated_flutter_widgets/animated_widgets/scroll_widget/animated_listview_builder.dart';
import 'package:animated_flutter_widgets/enums/enums.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatelessWidget {
  /// Type of animation for the list view
  final ScrollWidgetAnimationType scrollWidgetAnimationType;

  /// Constructor
  const AnimatedListView({
    super.key,
    required this.scrollWidgetAnimationType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FadeInAnimatedAppBar(
        backgroundColor: ColorUtility.magenta,
        title: const Text('Animated ListView'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedListViewBuilder(
          itemCount: 25,
          customColor: ColorUtility.magenta,
          animationType: scrollWidgetAnimationType,
          itemBuilder: (BuildContext context, int index) {
            final bool isColored = scrollWidgetAnimationType == ScrollWidgetAnimationType.listColored;
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
          },
        ),
      ),
    );
  }
}