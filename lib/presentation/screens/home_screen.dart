import 'package:flutter/material.dart';
import 'package:personal_trainer/presentation/components/mobile_drawer.dart';
import 'package:personal_trainer/presentation/widgets/about.dart';
import 'package:personal_trainer/presentation/widgets/formations.dart';
import 'package:personal_trainer/presentation/widgets/header.dart';
import 'package:personal_trainer/presentation/widgets/hero_banner.dart';

import '../components/animated_section.dart';
import '../managers/menu_manager.dart';
import '../managers/scroll_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey formationsKey = GlobalKey();
  late ScrollController _scrollController;
  late ScrollManager _scrollManager;
  late MenuManager _menuManager;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isScrolled = false;
  bool _aboutVisible = false;
  bool _formationsVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _scrollManager = ScrollManager(
      scrollController: _scrollController,
      sectionKeys: {
        0: homeKey,
        1: aboutKey,
        2: formationsKey,
      },
    );

    _menuManager = MenuManager(scrollManager: _scrollManager);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bool isScrolled = _scrollController.offset > 0;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }

    _scrollManager.checkVisibility(aboutKey, context, (isVisible) {
      if (isVisible != _aboutVisible) {
        setState(() {
          _aboutVisible = isVisible;
        });
      }
    });

    _scrollManager.checkVisibility(formationsKey, context, (isVisible) {
      if (isVisible != _formationsVisible) {
        setState(() {
          _formationsVisible = isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: MobileDrawer(
        onMenuItemSelected: _menuManager.onMenuClick,
      ),
      body: Stack(
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    HeroBanner(key: homeKey),
                    AnimatedSection(
                      key: aboutKey,
                      isVisible: _aboutVisible,
                      child: const AboutSection(),
                    ),
                    AnimatedSection(
                      key: formationsKey,
                      isVisible: _formationsVisible,
                      child: const Formations(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(
              isScrolled: _isScrolled,
              onMenuItemSelected: _menuManager.onMenuClick,
            ),
          ),
        ],
      ),
    );
  }
}
