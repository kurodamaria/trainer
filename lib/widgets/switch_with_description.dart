import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchWithDescription extends StatelessWidget {
  SwitchWithDescription({
    Key? key,
    required this.description,
    bool? initialValue,
    this.descriptionStyle,
    this.onChanged,
  })  : value = (initialValue ?? false).obs,
        super(key: key);

  final String description;
  final RxBool value;
  final TextStyle? descriptionStyle;
  final ValueChanged? onChanged;

  static final _defaultDescriptionStyle = TextStyle(fontSize: 12);

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
              onChanged?.call(v);
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
