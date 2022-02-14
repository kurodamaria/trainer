import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart' hide Value;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/tools/datetime.dart';
import 'package:trainer/tools/keys.dart' as keys;

part 'database_list_event.dart';

part 'database_list_state.dart';

class DatabaseListBloc<T>
    extends Bloc<DatabaseListEvent, DatabaseListState<T>> {
  final ChunkRepository repository;

  DatabaseListBloc({
    required this.repository,
    required MultiSelectable<T> query,
  }) : super(DatabaseListInitial<T>(query)) {
    on<EventDatabaseListAddChunk>((event, emit) async {
      final rowId = await repository.addChunk(event.itemToAdd);
      emit(StateDatabaseListUpdated<T>(state.query, rowId));
    });
    on<EventDatabaseListDeleteChunk>((event, emit) async {
      final rowId = await repository.deleteChunk(event.itemToDelete);
      emit(StateDatabaseListUpdated<T>(state.query, rowId));
    });
    on<EventDatabaseListDeleteSubject>((event, emit) async {
      if (hasTodayBox()) {
        final sp = Get.find<SharedPreferences>();
        final todayId = sp.getInt(keys.keyTodayBoxId);
        if (event.itemToDelete.id == todayId) {
          await sp.remove(keys.keyTodayBox);
        }
      }
      final rowId = await repository.deleteSubject(event.itemToDelete);
      emit(StateDatabaseListUpdated<T>(state.query, rowId));
    });
    on<EventDatabaseListAddSubject>((event, emit) async {
      final rowId = await repository.addSubject(event.itemToAdd);
      emit(StateDatabaseListUpdated<T>(state.query, rowId));
    });
    on<EventCreateTodayBox>((event, emit) async {
      final sp = Get.find<SharedPreferences>();
      final tb = sp.getString(keys.keyTodayBox);
      if (tb == null || !_isTheBoxToday(tb)) {
        final rowId = await repository.addSubject(
            SubjectsCompanion.insert(name: dateFormat.format(DateTime.now())));
        sp.setInt(keys.keyTodayBoxId, rowId);
        sp.setString(
            keys.keyTodayBox, '${DateTime.now().toIso8601String()} $rowId');
        emit(StateDatabaseListUpdated<T>(query, rowId));
      }
    });
  }

  MultiSelectable<Chunk>? get todayQuery {
    if (hasTodayBox()) {
      final sp = Get.find<SharedPreferences>();
      final tb = sp.getString(keys.keyTodayBox)!;
      final subjectId = int.parse(tb.split(' ')[1]);

      return repository.database.chunks.select()
        ..where((tbl) => tbl.subject.equals(subjectId));
    }
    return null;
  }

  Future<Subject?> get todaySubject async {
    if (hasTodayBox()) {
      final sp = Get.find<SharedPreferences>();
      final selection = repository.database.subjects.select()
        ..where((tbl) => tbl.id.equals(sp.getInt(keys.keyTodayBoxId)));
      return await selection.getSingle();
    } else {
      return null;
    }
  }

  bool hasTodayBox() {
    final sp = Get.find<SharedPreferences>();
    final tb = sp.getString(keys.keyTodayBox);
    if (tb == null) {
      return false;
    }
    return _isTheBoxToday(tb);
  }

  bool _isTheBoxToday(String boxString) {
    final split = boxString.split(' ');
    final day = DateTime.parse(split[0]).day;
    return day == DateTime.now().day;
  }
}
