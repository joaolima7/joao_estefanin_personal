import 'package:flutter/material.dart';
import '../../config/appearance/app_colors.dart';

class MobileMenuItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  const MobileMenuItem({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
  });

  @override
  State<MobileMenuItem> createState() => _MobileMenuItemState();
}

class _MobileMenuItemState extends State<MobileMenuItem> with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _arrowSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.98,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
    _slideAnimation =
        Tween<double>(
          begin: 0.0,
          end: 8.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _arrowSlideAnimation =
        Tween<double>(
          begin: 0.0,
          end: 6.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered && !_isPressed) {
      _animationController.forward();
    } else if (!isHovered && !_isPressed) {
      _animationController.reverse();
    }
  }

  void _handlePress(bool isPressed) {
    setState(() => _isPressed = isPressed);
    if (isPressed) {
      _animationController.forward();
    } else if (!_isHovered) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovered || _isPressed;

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => _handlePress(true),
        onTapUp: (_) => _handlePress(false),
        onTapCancel: () => _handlePress(false),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary.withAlpha(26) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: isActive ? AppColors.primary : Colors.transparent,
                        width: 4,
                      ),
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(26),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Transform.translate(
                    offset: Offset(_slideAnimation.value, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                              color: isActive ? AppColors.primary : AppColors.neutralGreyDark,
                              letterSpacing: isActive ? 0.5 : 0,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Icon(widget.icon),
                                Text(widget.text),
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(_arrowSlideAnimation.value, 0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutCubic,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: isActive ? 18 : 16,
                              color: isActive ? AppColors.primary : AppColors.neutralGreyLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
