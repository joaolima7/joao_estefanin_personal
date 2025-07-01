import 'package:flutter/material.dart';
import 'package:personal_trainer/presentation/components/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(),
        ],
      ),
    );
  }
}
