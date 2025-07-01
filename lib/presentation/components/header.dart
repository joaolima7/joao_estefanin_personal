import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../config/appearance/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.neutralGreyDark.withAlpha(200),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            )
          else
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
        ],
      ),
    );
  }
}
