import 'package:flutter/material.dart';
import 'package:trainer/app/app.dart';
import 'package:trainer/services/services.dart';

void main() async {
  await Services.init();
  runApp(const TrainerApp());
}
