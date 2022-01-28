import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/widgets/chunk_card.dart';
import 'package:trainer/widgets/error_box.dart';
import 'package:trainer/widgets/loading_indicator.dart';

import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final logic = Get.find<SearchLogic>();
  final config = Get.find<SearchLogic>().config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result for ${config.keyword}'),
        actions: [IconButton(onPressed: (){
          logic.search();
        }, icon: Icon(Icons.map))],
      ),
      body: logic.obx(
        (state) => ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ChunkCard(chunk: state![index]);
          },
          itemCount: state!.length,
        ),
        onLoading: Center(child: LoadingIndicator()),
        onError: (msg) => Center(
            child: ErrorBox(
                title: '', message: msg ?? 'Sorry. No detailed info.')),
      ),
    );
  }
}
