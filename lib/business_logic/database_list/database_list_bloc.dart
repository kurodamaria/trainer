import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:meta/meta.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';

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
      await repository.addChunk(event.itemToAdd);
      emit(StateDatabaseListUpdated<T>(state.query));
    });
    on<EventDatabaseListDeleteChunk>((event, emit) async {
      await repository.deleteChunk(event.itemToDelete);
      emit(StateDatabaseListUpdated<T>(state.query));
    });
    on<EventDatabaseListAddSubject>((event, emit) async {
      await repository.addSubject(event.itemToAdd);
      emit(StateDatabaseListUpdated<T>(state.query));
    });
  }
}
