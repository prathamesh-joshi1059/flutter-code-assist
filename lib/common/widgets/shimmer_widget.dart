import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;

  const ShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorsUtility.gray.withOpacity(0.3),
        highlightColor: ColorsUtility.white.withOpacity(0.1),
        child: child);
  }
}
