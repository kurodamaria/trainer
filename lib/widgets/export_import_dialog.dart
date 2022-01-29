import 'package:flutter/material.dart';
import 'package:trainer/tools/eximport.dart';

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
              children: const [
                TextButton(
                  onPressed: exportAll,
                  child: Text('Export'),
                ),
                TextButton(
                  onPressed: importFromFile,
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
