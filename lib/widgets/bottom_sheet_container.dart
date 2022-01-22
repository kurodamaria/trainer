import 'package:flutter/material.dart';
import 'package:trainer/widgets/bottom_sheet_handler.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}
