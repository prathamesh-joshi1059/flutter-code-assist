import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class AssetImageWidget extends StatelessWidget {
  final String imageUrl;
  final Size? imageSize;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;

  const AssetImageWidget(
      {super.key,
      required this.imageUrl,
      this.imageSize,
      this.boxFit,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return (imageUrl.isNotEmpty)
        ? ClipRRect(
            borderRadius: borderRadius != null
                ? borderRadius!
                : BorderRadius.circular(0), // Image border
            child: Image.asset(
              imageUrl.toString(),
              fit: boxFit ?? BoxFit.cover,
              height: imageSize?.height,
              width: imageSize?.width,
            ),
          )
        : SizedBox(
            height: imageSize?.height,
            width: imageSize?.width,
            child: const Center(
                child: Icon(Icons.error, color: ColorsUtility.red)));
  }
}
