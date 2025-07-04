import 'package:flutter/material.dart';
import '../../config/appearance/app_colors.dart';

class MenuItem extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? defaultColor;
  final Color? hoverColor;
  final Duration animationDuration;

  const MenuItem({
    super.key,
    required this.text,
    this.onTap,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w600,
    this.defaultColor,
    this.hoverColor,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 1.05,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.defaultColor ?? AppColors.neutralGreyDark.withAlpha(200);
    final hoverColor = widget.hoverColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _isHovered ? hoverColor.withAlpha(20) : Colors.transparent,
                ),
                child: AnimatedDefaultTextStyle(
                  duration: widget.animationDuration,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    color: _isHovered ? hoverColor : defaultColor,
                    fontWeight: widget.fontWeight,
                  ),
                  child: Text(widget.text),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
