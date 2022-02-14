part of 'database_list_bloc.dart';

@immutable
abstract class DatabaseListState<T> {
  const DatabaseListState(this.query);

  final MultiSelectable<T> query;
}

class DatabaseListInitial<T> extends DatabaseListState<T> {
  const DatabaseListInitial(MultiSelectable<T> query) : super(query);
}

class StateDatabaseListUpdated<T> extends DatabaseListState<T> {
  const StateDatabaseListUpdated(MultiSelectable<T> query) : super(query);
}
