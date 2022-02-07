part of 'services.dart';

const _subjectsBoxName = 'subjects';
const _settingsBoxName = 'settings';

class _PersistenceService {
  Future<void> _init() async {
    Hive.registerAdapter(SubjectAdapter());
    Hive.registerAdapter(ChunkAdapter());

    await _openSettingsBox();
    await _openSubjectsBox();
  }

  late final Box<Subject> subjectsBox;
  late final Box<dynamic> settingsBox;

  Future<void> _openSubjectsBox() async {
    subjectsBox = await Hive.openBox<Subject>(_subjectsBoxName);
  }

  Future<void> _openSettingsBox() async {
    settingsBox = await Hive.openBox<dynamic>(_settingsBoxName);
  }

  String getCardPreviewPreference() {
    return settingsBox.get(
      settings.cardPreviewKey,
      defaultValue: settings.cardPreviewPlainText,
    );
  }

  Future<Box<Chunk>> openChunkBox(Subject subject) async {
    return await Hive.openBox<Chunk>(subject.chunkBoxName);
  }
}
