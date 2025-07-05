import 'package:flutter/material.dart';

class AnimatedSection extends StatelessWidget {
  const AnimatedSection({
    super.key,
    required this.isVisible,
    required this.child,
  });

  final bool isVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      child: AnimatedSlide(
        offset: isVisible ? Offset.zero : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        child: child,
      ),
    );
  }
}
