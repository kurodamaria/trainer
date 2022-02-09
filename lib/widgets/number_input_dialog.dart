import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberInputDialog extends StatelessWidget {
  NumberInputDialog({
    Key? key,
    required this.max,
    required this.min,
    this.integerOnly = true,
  }) : super(key: key);

  final num max;
  final num min;
  final bool integerOnly;

  final RxBool inputValid = false.obs;
  double _value = double.nan;

  bool _isInputValid(String input) {
    final parsed = double.tryParse(input);
    if (parsed != null) {
      _value = parsed;
    } else {
      return false;
    }
    return parsed <= max &&
        parsed >= min &&
        (integerOnly ? parsed.compareTo(parsed.toInt()) == 0 : true);
  }

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Input a number between [$min, $max]',
              ),
              onChanged: (input) {
                inputValid.value = _isInputValid(input);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (input) {
                final parsed = double.tryParse(input ?? '');
                if (parsed == null) {
                  return 'Input is not a number.';
                } else if (parsed > max || parsed < min) {
                  return 'Input is not in the range.';
                } else if (integerOnly &&
                    parsed.compareTo(parsed.toInt()) != 0) {
                  return 'Input is not a integer.';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back(result: double.nan);
                  },
                  child: const Text('Cancel'),
                ),
                Obx(() {
                  return TextButton(
                    onPressed: inputValid.isTrue
                        ? () {
                            Get.back(result: integerOnly ? _value.toInt() : _value);
                          }
                        : null,
                    child: const Text('OK'),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
