import 'package:trainer/models/models.dart';

class ChunkFilters {
  static bool onlyMarkedFilter(Chunk chunk) {
    return chunk.marked == true;
  }

  static bool everythingFilter(Chunk chunk) {
    return true;
  }

  static bool _hasMathjax(String s) {
    return s.contains(r'\(') || s.contains(r'$$');
  }

  static bool hasMathjaxContent(Chunk chunk) {
    return _hasMathjax(chunk.content);
  }

  static bool hasMathjaxHint(Chunk chunk) {
    return _hasMathjax(chunk.hints);
  }

  static bool hasMathjax(Chunk chunk) {
    return hasMathjaxContent(chunk) || hasMathjaxHint(chunk);
  }
}
