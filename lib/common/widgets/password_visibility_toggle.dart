import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class PasswordVisibilityToggle extends StatelessWidget {
  final ValueNotifier<bool> obscureTextNotifier;

  const PasswordVisibilityToggle({
    super.key,
    required this.obscureTextNotifier,
  });

  IconData get visibilityIcon {
    return obscureTextNotifier.value
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        visibilityIcon,
        size: buildWidth(context) * .05,
      ),
      color: ColorsUtility.dimGray,
      onPressed: () {
        obscureTextNotifier.value = !obscureTextNotifier.value;
      },
    );
  }
}
