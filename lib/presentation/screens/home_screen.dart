import 'package:flutter/material.dart';
import 'package:personal_trainer/presentation/components/mobile_drawer.dart';
import 'package:personal_trainer/presentation/widgets/about.dart';
import 'package:personal_trainer/presentation/widgets/header.dart';
import 'package:personal_trainer/presentation/widgets/hero_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bool isScrolled = _scrollController.offset > 0;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: MobileDrawer(
        onMenuItemSelected: _onMenuClick,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80),
                HeroBanner(key: homeKey),
                AboutSection(key: aboutKey),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(
              isScrolled: _isScrolled,
              onMenuItemSelected: _onMenuClick,
            ),
          ),
        ],
      ),
    );
  }

  void _onMenuClick(int index) {
    double targetPosition = 0;

    switch (index) {
      case 0:
        targetPosition = 0;
        break;
      case 1:
        final RenderBox aboutRenderBox = aboutKey.currentContext!.findRenderObject() as RenderBox;
        targetPosition = aboutRenderBox.localToGlobal(Offset.zero).dy;
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      default:
        return;
    }

    _scrollController.animateTo(
      targetPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }
}
