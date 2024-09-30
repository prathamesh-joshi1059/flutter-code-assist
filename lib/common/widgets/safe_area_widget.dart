import 'package:flutter/material.dart';

class SafeAreaWidget extends StatelessWidget {
  final Widget child;

  const SafeAreaWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        right: true, left: true, top: false, bottom: false, child: child);
  }
}
