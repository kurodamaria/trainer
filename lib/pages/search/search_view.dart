import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/widgets/chunk_card.dart';
import 'package:trainer/widgets/error_box.dart';
import 'package:trainer/widgets/loading_indicator.dart';
import 'package:trainer/widgets/not_found.dart';

import 'search_logic.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final logic = Get.find<SearchLogic>();

  final config = Get.find<SearchLogic>().config;


  @override
  void initState() {
    super.initState();
    logic.search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: logic.obx(
        (state) => ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ChunkCard(chunk: state![index]);
          },
          itemCount: state!.length,
        ),
        onEmpty: const NotFound(),
        onLoading: const Center(child: LoadingIndicator()),
        onError: (msg) => Center(
          child:
              ErrorBox(title: '', message: msg ?? 'Sorry. No detailed info.'),
        ),
      ),
    );
  }
}
