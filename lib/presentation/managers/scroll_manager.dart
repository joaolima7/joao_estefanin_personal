import 'package:flutter/material.dart';

class ScrollManager {
  final ScrollController scrollController;
  final Map<int, GlobalKey> sectionKeys;
  final double headerHeight;

  ScrollManager({
    required this.scrollController,
    required this.sectionKeys,
    this.headerHeight = 80,
  });

  void scrollToSection(int index) {
    final GlobalKey? targetKey = sectionKeys[index];
    if (targetKey?.currentContext != null) {
      final RenderObject? renderObject = targetKey!.currentContext!.findRenderObject();
      if (renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        final targetPosition = position.dy + scrollController.offset - headerHeight;

        scrollController.animateTo(
          targetPosition.clamp(0.0, scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void checkVisibility(GlobalKey key, BuildContext context, ValueChanged<bool> onVisibilityChanged) {
    final RenderObject? renderObject = key.currentContext?.findRenderObject();
    if (renderObject is RenderBox) {
      final position = renderObject.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;

      final isVisible = position.dy < screenHeight && position.dy + renderObject.size.height > 0;
      onVisibilityChanged(isVisible);
    }
  }
}
