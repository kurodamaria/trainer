import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/widgets/default_future_builder.dart';

class HiveBoxFutureBuilder<T> extends StatelessWidget {
  const HiveBoxFutureBuilder({
    Key? key,
    required this.boxName,
    required this.builder,
  }) : super(key: key);

  final String boxName;
  final Widget Function(BuildContext, Box<T>) builder;

  @override
  Widget build(BuildContext context) {
    return DefaultFutureBuilder(
      builder: builder,
      future: Hive.openBox<T>(boxName),
    );
  }
}
