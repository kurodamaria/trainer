import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

class SearchState {
  /// Data pool for searching
  final List<String> chunkBoxes = Get.arguments['chunkBoxes'] as List<String>;

  /// Type of search
  final SearchType type = Get.arguments['searchType'] as SearchType;

  /// pattern to search
  final String keyword = Get.arguments['keyword'] as String;

  /// Search Result
  final RxList<Chunk> result = RxList<Chunk>();
}

// How do you express content && hintsONly?
enum SearchType {
  content,
  hints,
  tags,
}
