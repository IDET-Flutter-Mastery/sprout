import 'package:flutter/material.dart';

import '../theme/app_motion.dart';

/// -----------------------------------------------------------------------
/// StaggeredFadeIn — wraps a list item so it fades and slides up into
/// place, with a small delay per index. This is what gives the plant
/// list its gentle "cascade" on first appearance, instead of just
/// popping onto the screen. Built entirely from implicit animations —
/// no animation package required.
/// -----------------------------------------------------------------------
class StaggeredFadeIn extends StatelessWidget {
  const StaggeredFadeIn({
    super.key,
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppMotion.medium + Duration(milliseconds: index * 45),
      curve: AppMotion.enter,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 18),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
