import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletonizer extends StatelessWidget {
  final bool enabled;
  final Widget child;
  final PaintingEffect? effect;
  const AppSkeletonizer({
    super.key,
    this.enabled = true,
    required this.child,
    this.effect,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      effect:
          effect ??
          const ShimmerEffect(
            baseColor: Color(0xFFEDEDED),
            highlightColor: Color(0xFFF5F5F5),
          ),
      child: child,
    );
  }
}
