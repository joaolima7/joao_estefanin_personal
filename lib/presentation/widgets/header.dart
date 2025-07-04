import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../config/appearance/app_colors.dart';
import '../components/menu_item.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.isScrolled = false,
    required this.onMenuItemSelected,
  });

  final bool isScrolled;
  final ValueChanged<int> onMenuItemSelected;

  final List<String> menuItems = const [
    'Início',
    'Sobre Mim',
    'Formação',
    'Serviços',
    'Depoimentos',
    'Contato',
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.symmetric(
        horizontal: (!isMobile && !isTablet) ? 0 : 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        gradient: isScrolled
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withAlpha(25),
                  Colors.white.withAlpha(51),
                  Colors.white.withAlpha(128),
                  Colors.white.withAlpha(194),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
        color: isScrolled ? Colors.white : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isScrolled ? 26 : 13),
            blurRadius: isScrolled ? 10 : 6,
            offset: Offset(0, isScrolled ? 2 : 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: (!isMobile && !isTablet) ? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'João Victor ',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.neutralGreyDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Estefanin',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          if (!isMobile && !isTablet)
            Row(
              spacing: 20,
              children: [
                for (final item in menuItems)
                  MenuItem(
                    text: item,
                    onTap: () => onMenuItemSelected(menuItems.indexOf(item)),
                  ),
              ],
            )
          else
            _MenuButton(),
        ],
      ),
    );
  }
}

class _MenuButton extends StatefulWidget {
  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.95,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openEndDrawer(),
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isHovered ? AppColors.primary.withAlpha(26) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.menu,
                  size: 24,
                  color: _isHovered ? AppColors.primary : AppColors.neutralGreyDark,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
