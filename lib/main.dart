import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:personal_trainer/personal_trainer.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    const PersonalTrainer(),
  );
}
