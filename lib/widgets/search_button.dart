import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/pages/search/search_state.dart';
import 'package:trainer/services/services.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await Get.dialog(TextInputDialog(labels: ['Keyword']));
        if (result != null) {
          Get.toNamed(
            Routes.searchPage.name,
            arguments: {
              'chunkBoxes': Services.persist.subjectsBox.values.map((e) => e.chunkBoxName).toList(),
            },
          );
        }
      },
      icon: const Icon(Icons.search),
    );
  }
}
