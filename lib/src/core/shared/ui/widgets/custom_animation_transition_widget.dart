import 'package:flutter/material.dart';

class CustomAnimationTransitionWidget extends StatelessWidget {
  final Widget child;
  const CustomAnimationTransitionWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: child,
    );
  }
}
