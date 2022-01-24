import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchWithDescription extends StatelessWidget {
  const SwitchWithDescription({
    Key? key,
    required this.description,
    required this.value,
    this.descriptionStyle,
  }) : super(key: key);

  final String description;
  final RxBool value;
  final TextStyle? descriptionStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(description, style: descriptionStyle),
        Obx(() {
          return Switch(
            onChanged: (v) {
              value.value = v;
            },
            value: value.value,
          );
        }),
      ],
    );
  }
}
