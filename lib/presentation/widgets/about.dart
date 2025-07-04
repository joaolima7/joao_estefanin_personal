import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../config/appearance/app_colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final sizeScreen = MediaQuery.of(context).size;

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
          child: isTablet || isMobile ? _buildMobileTabletLayout(sizeScreen, isTablet) : _buildDesktopLayout(sizeScreen),
        ),
      ),
    );
  }

  Widget _buildMobileTabletLayout(Size sizeScreen, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 20),
        _buildDescription(),
        const SizedBox(height: 16),
        _buildPhilosophy(),
        const SizedBox(height: 30),

        Center(
          child: _buildImageWithBadge(isMobile: true, sizeScreen: sizeScreen, isTablet: isTablet),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(Size sizeScreen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 20),
              _buildDescription(),
              const SizedBox(height: 16),
              _buildPhilosophy(),
            ],
          ),
        ),

        const SizedBox(width: 50),

        Expanded(
          flex: 4,
          child: _buildImageWithBadge(isMobile: false, sizeScreen: sizeScreen),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        children: [
          const TextSpan(text: 'Quem '),
          TextSpan(
            text: 'Sou Eu',
            style: TextStyle(color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Sou João Victor Estefanin, profissional de Educação Física com mais de 4 anos de experiência dedicados à transformação de vidas através do exercício físico e bem-estar.\n\n'
      'Minha trajetória inclui passagens por academias renomadas da região, onde desenvolvi expertise em treinamento personalizado, funcional e musculação. Acredito que cada pessoa é única e merece um programa específico para seus objetivos.\n\n'
      'Trabalho tanto presencialmente quanto online, oferecendo acompanhamento personalizado para hipertrofia, emagrecimento, reabilitação e condicionamento físico para todas as idades.',
      style: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPhilosophy() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Minha filosofia: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextSpan(
            text: '"Treinar vai além de exercícios. É sobre criar hábitos saudáveis, fortalecer a mente e descobrir o seu melhor potencial."',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWithBadge({required bool isMobile, required Size sizeScreen, bool isTablet = false}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageWidth = isMobile ? constraints.maxWidth : constraints.maxWidth;
        double imageHeight = isMobile ? (imageWidth * 1.5).clamp(350.0, 880.0) : (imageWidth * 1.2).clamp(400.0, 600.0);

        return SizedBox(
          width: imageWidth,
          height: imageHeight + 40,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/foto_jv.jpg',
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: 10,
                left: -20,
                child: _buildBadge(sizeScreen, isMobile, isTablet),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge(Size sizeScreen, bool isMobile, bool isTablet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      width: isMobile || isTablet ? sizeScreen.width * 0.45 : sizeScreen.width * 0.22,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Especialista em',
            style: TextStyle(
              fontSize: isMobile || isTablet ? sizeScreen.width * 0.02 : sizeScreen.width * 0.009,
              color: AppColors.neutralGreyLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Treinamento Personalizado',
            style: TextStyle(
              fontSize: isMobile || isTablet ? sizeScreen.width * 0.023 : sizeScreen.width * 0.01,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
