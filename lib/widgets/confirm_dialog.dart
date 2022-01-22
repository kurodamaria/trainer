import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key, required this.msg, required this.action}) : super(key: key);

  final String msg;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Text('Confirm', style: Get.textTheme.headline6),
            Text(msg, style: Get.textTheme.bodyText1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: const Text('Cancel')),
                const SizedBox(width: 24),
                TextButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: Text(action, style: TextStyle(color: Colors.red)),
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.red.withOpacity(0.1))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
