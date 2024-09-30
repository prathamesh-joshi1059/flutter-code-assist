import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/cache_network_image_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_moreless_label_widget.dart';

class ShowMoreLessListWidget extends StatefulWidget {
  final List workDetailsList;
  final List selectedCheckList;
  final String keyName;
  final bool isPPEList;

  const ShowMoreLessListWidget(
      {super.key,
      required this.workDetailsList,
      this.selectedCheckList = const [],
      this.isPPEList = false,
      required this.keyName});

  @override
  State<ShowMoreLessListWidget> createState() => _ShowMoreLessListWidgetState();
}

class _ShowMoreLessListWidgetState extends State<ShowMoreLessListWidget> {
  ValueNotifier showMoreLessNotifier = ValueNotifier(true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    widget.workDetailsList.sort((a, b) => (a['name']).compareTo(b['name']));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: showMoreLessNotifier,
        builder: (context, child, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    (showMoreLessNotifier.value)
                        ? widget.workDetailsList.length > 5
                            ? 5
                            : widget.workDetailsList.length
                        : widget.workDetailsList.length,
                    (index) => textWithNumbers(index)),
              ),
              if (widget.workDetailsList.length > 5)
                Column(
                  children: [
                    SizedBox(height: 3.w),
                    ShowMoreLessLabelWidget(
                      isShowMore: showMoreLessNotifier.value,
                      onTap: () => _onTapShowMoreLess(),
                    ),
                  ],
                )
            ],
          );
        });
  }

  _onTapShowMoreLess() {
    showMoreLessNotifier.value = !showMoreLessNotifier.value;
  }

  textWithNumbers(index) {
    return Padding(
      padding: EdgeInsets.only(top: (widget.isPPEList) ? 2.w : 0.5.w),
      child: Row(
        crossAxisAlignment: (widget.isPPEList)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          if (widget.isPPEList)
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                  height: 10.w,
                  child: (widget.workDetailsList[index]['image'] != null)
                      ? CacheNetworkImageWidget(
                          imageUrl:
                              widget.workDetailsList[index]['image'].toString())
                      : ShimmerWidget(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorsUtility.gray,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                ),
                SizedBox(width: 2.w),
              ],
            )
          else
            TextWidget(
              "${index + 1}. ",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 15, FontWeight.normal, false),
            ),
          SizedBox(width: 1.w),
          SizedBox(
            width: 76.w,
            child: TextWidget(
              widget.workDetailsList[index]['name'].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 15, FontWeight.normal, false),
            ),
          )
        ],
      ),
    );
  }
}
