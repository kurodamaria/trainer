import 'dart:async';

import 'package:flutter/material.dart';

/// Call [builder] every [duration] passed.
class TickBuilder extends StatefulWidget {
  const TickBuilder({
    Key? key,
    required this.duration,
    required this.builder,
    this.onDurationPassed,
  }) : super(key: key);

  final Duration duration;
  final VoidCallback? onDurationPassed;

  final WidgetBuilder builder;

  @override
  State<TickBuilder> createState() => _TickBuilderState();
}

class _TickBuilderState extends State<TickBuilder> {
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(widget.duration, (timer) {
      _t = timer;
      setState(() {
        widget.onDurationPassed?.call();
      });
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
