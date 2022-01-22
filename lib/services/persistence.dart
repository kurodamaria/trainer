part of 'services.dart';

const _subjectsBoxName = 'subjects';

class _PersistenceService {
  Future<void> _init() async {
    Hive.registerAdapter(SubjectAdapter());
    Hive.registerAdapter(ChunkAdapter());
    Hive.registerAdapter(AttemptAdapter());

    await _openSubjectsBox();
  }

  late final Box<Subject> subjectsBox;

  Future<void> _openSubjectsBox() async {
    subjectsBox = await Hive.openBox<Subject>(_subjectsBoxName);
  }

  Future<Box<Chunk>> openChunkBox(Subject subject) async {
    return await Hive.openBox<Chunk>(subject.chunkBoxName);
  }

  Future<Box<Attempt>> openAttemptBox(Chunk chunk) async {
    return await Hive.openBox<Attempt>(chunk.attemptBoxName);
  }
}
