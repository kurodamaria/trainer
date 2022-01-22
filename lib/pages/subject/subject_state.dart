import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/models/models.dart';

class SubjectState {
  final Subject subject = Get.arguments['subject'];
  final Box<Chunk> chunkBox = Get.arguments['chunkBox'];
}
