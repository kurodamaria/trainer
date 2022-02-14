import 'package:flutter/material.dart';

Color effectiveLevelColor(double level) {
  if (level <= 0.1) {
    return Colors.purpleAccent;
  } else if (level <= 0.2) {
    return Colors.redAccent;
  } else if (level <= 0.3) {
    return Colors.red;
  } else if (level <= 0.4) {
    return Colors.brown;
  } else if (level <= 0.5) {
    return Colors.amber;
  } else if (level <= 0.6) {
    return Colors.amberAccent;
  } else if (level <= 0.7) {
    return Colors.blue;
  } else if (level <= 0.8) {
    return Colors.lightBlueAccent;
  } else if (level <= 0.9) {
    return Colors.green;
  } else {
    return Colors.lightGreenAccent;
  }
}
