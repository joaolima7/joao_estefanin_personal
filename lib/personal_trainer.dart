import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'router/app_router.dart';

class PersonalTrainer extends StatelessWidget {
  const PersonalTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1200, name: DESKTOP),
          const Breakpoint(start: 1201, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: AppRouter.homeRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
