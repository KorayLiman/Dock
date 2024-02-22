import 'dart:ui';

import 'package:flutter/material.dart';

@Deprecated('This is not a great API, and may be removed in the future')
class Blurred extends StatelessWidget {
  @Deprecated('This is not a great API, and may be removed in the future')
  const Blurred({
    required this.child,
    this.blur = 10,
    this.blendMode = BlendMode.srcOver,
    this.borderRadius,
    this.overlay,
    super.key,
  });

  final Widget child;
  final double blur;
  final BlendMode blendMode;
  final BorderRadius? borderRadius;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: BackdropFilter(
              blendMode: blendMode,
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                alignment: Alignment.center,
                child: overlay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
