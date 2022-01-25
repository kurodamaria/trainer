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

  static final _defaultDescriptionStyle = TextStyle(
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return Switch(
            onChanged: (v) {
              value.value = v;
            },
            value: value.value,
          );
        }),
        Text(
          description,
          style: Get.textTheme.bodyText1!
              .merge(_defaultDescriptionStyle)
              .merge(descriptionStyle),
        ),
      ],
    );
  }
}
