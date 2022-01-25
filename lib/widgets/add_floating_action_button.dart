import 'package:flutter/material.dart';

class AddFloatingActionButton extends StatelessWidget {
  const AddFloatingActionButton(
      {Key? key, this.toolTip, required this.onPressed}) : super(key: key);

  final String? toolTip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
      tooltip: toolTip,
    );
  }
}
