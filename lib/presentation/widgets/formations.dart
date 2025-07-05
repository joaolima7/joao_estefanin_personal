import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../config/appearance/app_colors.dart';
import '../../utils/consts/formations.dart';

class Formations extends StatelessWidget {
  const Formations({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
        vertical: isMobile ? 40 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: isTablet || isMobile ? _buildMobileTabletLayout(isMobile, isTablet) : _buildDesktopLayout(isMobile, isTablet),
        ),
      ),
    );
  }

  Widget _buildMobileTabletLayout(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle(isMobile, isTablet),
        const SizedBox(height: 10),
        _buildDescription(),
        const SizedBox(height: 40),

        ...formations.map(
          (formation) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: formation,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle(isMobile, isTablet),
        const SizedBox(height: 10),
        _buildDescription(),
        const SizedBox(height: 40),

        Row(
          children: [
            Expanded(child: formations[0]),
            const SizedBox(width: 20),
            Expanded(child: formations[1]),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: formations[2]),
            const SizedBox(width: 20),
            Expanded(child: formations[3]),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(bool isMobile, bool isTablet) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: isMobile
              ? 25
              : isTablet
              ? 30
              : 36,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        children: [
          const TextSpan(text: 'Formação e '),
          TextSpan(
            text: 'Qualificações',
            style: TextStyle(color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Educação contínua e especialização para oferecer o melhor em\ntreinamento personalizado para meus alunos.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: Colors.black87,
      ),
    );
  }
}
