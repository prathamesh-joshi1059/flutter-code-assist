import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/theme_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class ConfirmationDialogWidget extends StatefulWidget {
  final String titleText;
  final String subTitleText;
  final String firstBtnText;
  final String secondBtnText;
  final Function() firstBtnTap;
  final Function() secondBtnTap;
  final Widget? icon;
  final bool? showDivider;
  final TextStyle? style;
  final TextStyle? firstBtnStyle;
  final TextStyle? secondBtnStyle;

  const ConfirmationDialogWidget(
      {super.key,
      required this.titleText,
      required this.firstBtnTap,
      required this.secondBtnTap,
      required this.firstBtnText,
      required this.secondBtnText,
      required this.subTitleText,
      this.showDivider,
      this.icon,
      this.style,
      this.firstBtnStyle,
      this.secondBtnStyle});

  @override
  State<ConfirmationDialogWidget> createState() =>
      _ConfirmationDialogWidgetState();
}

class _ConfirmationDialogWidgetState extends State<ConfirmationDialogWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
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
            backgroundColor: ThemeUtility.background,
            icon: widget.icon,
            contentPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.all(1.w),
              child: Column(
                children: [
                  TextWidget(widget.titleText.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: widget.style,
                      softWrap: true),
                  SizedBox(
                    height: 2.w,
                  ),
                  TextWidget(widget.subTitleText.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyleUtility.interTextStyle(
                          ThemeUtility.textColor, 14, FontWeight.normal, false),
                      softWrap: true),
                  SizedBox(
                    height: 2.w,
                  ),
                ],
              ),
            ),
            content: Padding(
              padding: EdgeInsets.only(bottom: 1.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showDivider ?? false)
                    Divider(
                      height: 0,
                      color: ColorsUtility.platinum,
                      thickness: 5.sp,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => widget.firstBtnTap(),
                        child: TextWidget(
                          key: Key("btn_${widget.firstBtnText}"),
                          widget.firstBtnText.toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          softWrap: true,
                          style: widget.firstBtnStyle,
                        ),
                      ),
                      TextButton(
                        onPressed: () => widget.secondBtnTap(),
                        child: TextWidget(
                          key: Key("btn_${widget.secondBtnText}"),
                          widget.secondBtnText.toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          softWrap: true,
                          style: widget.secondBtnStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
