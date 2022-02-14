import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainer/app/app.dart';
import 'package:trainer/data/repository/chunk_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(await SharedPreferences.getInstance());
  Get.lazyPut(() => ChunkRepository());
  Get.lazyPut(() => ImagePicker());
  runApp(const TrainerApp());
}
