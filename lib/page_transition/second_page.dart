import 'package:animated_flutter_widgets/animated_widgets/appbars/fade_in_appbar.dart';
import 'package:animated_flutter_widgets/animated_widgets/appbars/slide_in_appbar.dart';
import 'package:animated_flutter_widgets/enums/enums.dart';
import 'package:example/utility/color.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final AppBarAnimationType? appBarAnimationType;

  const SecondPage({super.key, this.appBarAnimationType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const SecondPageBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    switch (appBarAnimationType) {
      case AppBarAnimationType.fadeIn:
        return _createAnimatedAppBar(FadeInAnimatedAppBar());
      case AppBarAnimationType.slideIn:
        return _createAnimatedAppBar(SlideInAnimatedAppBar());
      default:
        return _createStandardAppBar();
    }
  }

  PreferredSizeWidget _createAnimatedAppBar(PreferredSizeWidget appBar) {
    return appBar.copyWith(
      backgroundColor: ColorUtility.magenta,
      animationDuration: const Duration(milliseconds: 1000),
      title: const Text('Second Page'),
    );
  }

  AppBar _createStandardAppBar() {
    return AppBar(
      backgroundColor: ColorUtility.magenta,
      title: const Text('Second Page'),
    );
  }
}

class SecondPageBody extends StatelessWidget {
  const SecondPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.star,
            size: 80,
            color: ColorUtility.magenta,
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to the Second Page!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          GoBackButton(),
        ],
      ),
    );
  }
}

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorUtility.magenta,
      ),
      onPressed: () => Navigator.pop(context),
      child: const Text('Go Back'),
    );
  }
}