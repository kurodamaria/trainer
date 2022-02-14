part of 'database_list_bloc.dart';

@immutable
abstract class DatabaseListEvent {}

class EventDatabaseListAddChunk extends DatabaseListEvent {
  EventDatabaseListAddChunk({required this.itemToAdd});

  final ChunksCompanion itemToAdd;
}

class EventDatabaseListDeleteChunk extends DatabaseListEvent {
  EventDatabaseListDeleteChunk({required this.itemToDelete});

  final Chunk itemToDelete;
}

class EventDatabaseListAddSubject extends DatabaseListEvent {
  EventDatabaseListAddSubject(this.itemToAdd);

  final SubjectsCompanion itemToAdd;
}

class EventDatabaseListDeleteSubject extends DatabaseListEvent {
  EventDatabaseListDeleteSubject({required this.itemToDelete});

  final Subject itemToDelete;
}
