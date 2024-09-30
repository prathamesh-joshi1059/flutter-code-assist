import 'dart:io';

import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Size? imageSize;
  final BoxFit? boxFit;

  const CacheNetworkImageWidget(
      {super.key, required this.imageUrl, this.imageSize, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return (imageUrl.toString().trim() != "")
        ? (imageUrl.contains('https'))
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ColorsUtility.gray, width: 1)),
                clipBehavior: Clip.none,
                padding: const EdgeInsets.all(1),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ) /*CachedNetworkImage(
                imageUrl: imageUrl,
                height: imageSize?.height,
                width: imageSize?.width,
                // placeholder: (context, url) => ShimmerWidget(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: ColorsUtility.gray,
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //   ),
                // ),
                fit: boxFit ?? BoxFit.cover,
                errorWidget: (context, url, error) => SizedBox(
                    height: imageSize?.height,
                    width: imageSize?.width,
                    child: const Center(
                        child: Icon(Icons.error, color: ColorsUtility.red))),
              )*/
            : (imageUrl.contains('assets'))
                ? Image.asset(
                    imageUrl,
                    fit: BoxFit.scaleDown,
                  )
                : Image.file(File(imageUrl.toString()), fit: BoxFit.scaleDown)
        : SizedBox(
            height: imageSize?.height,
            width: imageSize?.width,
            child: const Center(
                child: Icon(Icons.error, color: ColorsUtility.red)));
  }
}
