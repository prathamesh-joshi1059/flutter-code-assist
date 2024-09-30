import 'package:flutter/material.dart';

class BoxShadowWidget extends StatelessWidget {
  final Widget child;

  const BoxShadowWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: -2,
              blurRadius: 20,
              offset: const Offset(0, -11), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
