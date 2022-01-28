import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/tools/chunk_filters.dart';

class SubjectState {
  static final filters = [
    ChunkFilters.everythingFilter,
    ChunkFilters.onlyMarkedFilter,
  ];

  final Subject subject = Get.arguments['subject'];
  final Box<Chunk> chunkBox = Get.arguments['chunkBox'];
  final currentFilterIndex = 0.obs;

  bool Function(Chunk c) get currentFilter => filters[currentFilterIndex.value];
  final pageController = PageController();
}
