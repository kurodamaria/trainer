import 'package:trainer/models/models.dart';

class ChunkFilters {
  static bool onlyMarkedFilter(Chunk chunk) {
    return chunk.markedNeedReview == true;
  }

  static bool everythingFilter(Chunk chunk) {
    return true;
  }
}
