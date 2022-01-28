import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/models/models.dart';

import 'search_state.dart';

class SearchLogic extends GetxController with StateMixin<List<Chunk>> {
  final SearchState config = SearchState();

  /// Perform the search
  Future<void> search() async {
    change(null, status: RxStatus.loading());
    final result = <Chunk>[];
    for (final chunkBoxName in config.chunkBoxes) {
      final box = await Hive.openBox<Chunk>(chunkBoxName);
      result.addAll(box.values.where(config.matcher));
    }
    if (result.isNotEmpty) {
      change(result, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }
}