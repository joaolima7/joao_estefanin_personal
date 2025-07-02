import 'package:flutter/material.dart';
import 'package:personal_trainer/presentation/components/mobile_drawer.dart';
import 'package:personal_trainer/presentation/widgets/header.dart';
import 'package:personal_trainer/presentation/widgets/hero_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MobileDrawer(),
      body: Column(
        children: [
          Header(),
          HeroBanner(),
        ],
      ),
    );
  }
}
