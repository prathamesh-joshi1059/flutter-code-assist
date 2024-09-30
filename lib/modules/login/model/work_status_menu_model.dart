import 'dart:ui';

class WorkStatusMenuModel {
  final String iconUrl;
  final String workTitleName;
  final String workCount;
  final Color backColor;
  final Color countBackColor;

  WorkStatusMenuModel(
      {required this.iconUrl,
      required this.workTitleName,
      required this.workCount,
      required this.countBackColor,
      required this.backColor});
}
