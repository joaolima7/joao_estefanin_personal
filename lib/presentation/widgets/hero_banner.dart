import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../config/appearance/app_colors.dart';
import '../components/stat_item.dart';
import '../components/outlined_cta_button.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final sizeScreen = MediaQuery.of(context).size;

    return SizedBox(
      height: isMobile ? 500 : 700,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hero_section.jpg',
            fit: BoxFit.cover,
          ),

          // Gradient superior para fusão com header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Colors.white,
                  Colors.white.withAlpha(230),
                  Colors.white.withAlpha(128),
                  Colors.white.withAlpha(77),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.08, 0.15, 0.25, 0.4],
              ),
            ),
          ),

          // Gradient inferior para escurecer o fundo
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(51),
                  Colors.black.withAlpha(105),
                  Colors.black.withAlpha(128),
                ],
                stops: const [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeroTitle(isMobile, isTablet),
                  const SizedBox(height: 24),
                  _buildHeroSubtitle(isMobile),
                  const SizedBox(height: 32),
                  OutlinedCtaButton(
                    text: 'Conheça meu trabalho',
                    onPressed: () {},
                  ),
                  _buildDivider(sizeScreen),
                  _buildStatsRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroTitle(bool isMobile, bool isTablet) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: isMobile
              ? 28
              : isTablet
              ? 38
              : 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.3,
        ),
        children: [
          const TextSpan(text: 'Resultados '),
          TextSpan(
            text: 'Reais',
            style: TextStyle(color: AppColors.primary),
          ),
          const TextSpan(text: ',\ncom Saúde e '),
          TextSpan(
            text: 'Técnica',
            style: TextStyle(color: AppColors.primary),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildHeroSubtitle(bool isMobile) {
    return Text(
      'João Victor Estefanin, Personal Trainer especializado em\n'
      'transformar vidas com orientação personalizada e\n'
      'metodologia comprovada.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: isMobile ? 14 : 18,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDivider(Size sizeScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Divider(
        color: Colors.white24,
        indent: sizeScreen.width * 0.25,
        endIndent: sizeScreen.width * 0.25,
      ),
    );
  }

  Widget _buildStatsRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatItem(number: '50+', label: 'Alunos Atendidos'),
        SizedBox(width: 40),
        StatItem(number: '4+', label: 'Anos de Experiência'),
      ],
    );
  }
}
