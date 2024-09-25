// AI confidence score for this refactoring: 97.73%
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
      appBar: const FadeInAnimatedAppBar(
        backgroundColor: ColorUtility.magenta,
        title: Text('Animated ListView'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedListViewBuilder(
          itemCount: 25,
          customColor: ColorUtility.magenta,
          animationType: scrollWidgetAnimationType,
          itemBuilder: (BuildContext context, int index) {
            final Color cardColor = (scrollWidgetAnimationType ==
                    ScrollWidgetAnimationType.listColored)
                ? ColorUtility.white
                : ColorUtility.magenta;
            final Color textColor = (scrollWidgetAnimationType ==
                    ScrollWidgetAnimationType.listColored)
                ? ColorUtility.magenta
                : ColorUtility.white;

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
          },
        ),
      ),
    );
  }
}