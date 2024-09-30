import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final List<Widget>? actionWidgets;
  final Widget? leading;
  final Color? bgColor;
  final double elevation;
  final TextStyle? titleTextStyle;
  final Color? titleColor;
  final bool isCenterTitle;
  final bool isBackButton;
  final bool isShowImg;
  final Function()? onBackButtonPressed;
  final double? leadingWidth;

  const CustomAppBar({
    super.key,
    required BuildContext context,
    required this.appBarTitle,
    required this.isCenterTitle,
    this.actionWidgets,
    this.onBackButtonPressed,
    this.leading,
    this.bgColor,
    this.elevation = 4.0,
    this.titleTextStyle,
    this.titleColor,
    this.isBackButton = false,
    this.isShowImg = false,
    this.leadingWidth,
    // Add more parameters here
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorsUtility.white,
      shadowColor: ColorsUtility.white,
      title: isShowImg
          ? leading
          : TextWidget(
              appBarTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  titleColor, 18, FontWeight.w500, false),
            ),
      actions: actionWidgets,
      leading: isShowImg ? null : leading,
      leadingWidth: leadingWidth,
      backgroundColor: bgColor,
      elevation: elevation,
      centerTitle: isCenterTitle,
      titleTextStyle: TextStyleUtility.interTextStyle(
          titleColor, 22, FontWeight.normal, false),
      automaticallyImplyLeading: isBackButton,
      titleSpacing: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
