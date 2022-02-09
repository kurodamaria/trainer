import 'dart:ffi';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/models/models.dart';
import 'package:uuid/uuid.dart';
import 'package:trainer/services/settings.dart' as settings;

part 'persistence.dart';

part 'global_env.dart';

part 'yorozuya.dart';

class _Services {
  final persist = _PersistenceService();
  final globalEnv = _GlobalEnvService();
  final yorozuya = _YorozuyaService();

  Future<void> init() async {
    await Hive.initFlutter();
    await persist._init();
    await globalEnv._init();
    await yorozuya._init();
  }

  final Uuid _uuidGenerator = const Uuid();

  String uuid() {
    return _uuidGenerator.v4();
  }

  Future<bool> boxExists(String name) {
    return Hive.boxExists(name);
  }
}

final Services = _Services();
