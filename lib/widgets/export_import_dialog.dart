import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/tools/eximport.dart';
import 'package:trainer/widgets/loading_dialog.dart';

class ExportImportDialog extends StatelessWidget {
  const ExportImportDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Export & Import'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: exportAll,
                  child: Text('Export'),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    showLoadingDialog(future: importFromFile());
                  },
                  child: Text('Import'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
