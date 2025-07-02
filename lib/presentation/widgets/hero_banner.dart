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
      height: isMobile ? 500 : 600,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hero_section.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withAlpha(105),
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
                  if (!isMobile) _buildStatsRow(),
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
        color: Colors.white70,
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
        StatItem(number: '200+', label: 'Clientes Atendidos'),
        SizedBox(width: 40),
        StatItem(number: '5 anos', label: 'de Experiência'),
        SizedBox(width: 40),
        StatItem(number: '98%', label: 'Taxa de Sucesso'),
      ],
    );
  }
}
