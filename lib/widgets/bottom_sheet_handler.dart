import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetHandler extends StatelessWidget {
  const BottomSheetHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: Get.mediaQuery.size.width / 4,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
