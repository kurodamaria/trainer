import 'package:trainer/models/models.dart';
import 'package:trainer/tools/datetime.dart';

class ChunkSorts {
  int compareDaysAgo(Chunk a, Chunk b) {
    return DateTimeTools.daysAgo(a.createdAt) -
        DateTimeTools.daysAgo(b.createdAt);
  }

  int compareMarked(Chunk a, Chunk b) {
    return a.marked && b.marked
        ? 0
        : a.marked
            ? 1
            : -1;
  }
}
